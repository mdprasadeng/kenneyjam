package game

import "core:c"
import "core:fmt"
import "core:log"
import "core:math"
import b2 "vendor:box2d"
import rl "vendor:raylib"

Direction :: enum {
	North,
	South,
	East,
	West,
}
ItemType :: enum {
	River,
	Road,
	Building,
	Rock,
	Grass,
	Cactus,
}
ItemRule :: struct {
	nextTo: ItemType,
	along:  Direction,
}
Item :: struct {
	spriteName:      string,
	spriteRotatedBy: f32,
	type:            ItemType,
	rules:           [dynamic; 4]ItemRule,
	hudX:            f32,
	hudY:            f32,
}

ItemMap :: struct {
	items:      [9][9]Item,
	ruleFailed: [9][9]bool,
}

Render :: struct {
	name:     string,
	rotateBy: f32,
}

allItems: [dynamic]Item

run: bool
cartTexture, parchmentTexture: rl.Texture
worldId: b2.WorldId
bodyId: b2.BodyId
debugDraw: b2.DebugDraw
b2Camera: rl.Camera2D
wCamera: rl.Camera2D
sprites: map[string]rl.Rectangle
rivers: [15]Render
roads: [15]Render
selectedItem: Item = {}
itemMap: ItemMap

GRID_SIZE: f32 = 64.0


SCREEN_SIZE := rl.Vector2{16 * GRID_SIZE, 9 * GRID_SIZE}

init :: proc() {
	run = true
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(i32(SCREEN_SIZE.x), i32(SCREEN_SIZE.y), "Odin + Raylib on the web")

	image := rl.LoadImage("assets/spritesheet_retina.png")
	defer rl.UnloadImage(image)

	rl.ImageFormat(&image, .UNCOMPRESSED_R8G8B8A8)

	// Anything in `assets` folder is available to load.
	cartTexture = rl.LoadTextureFromImage(image)


	parchmentTexture = rl.LoadTexture("assets/Textures/parchmentCrinkled.png")
	rl.SetTextureWrap(cartTexture, .REPEAT)

	wCamera = rl.Camera2D {
		offset   = rl.Vector2{0, 0},
		target   = rl.Vector2{0, 0},
		zoom     = 1,
		rotation = 0,
	}

	sprites = make(map[string]rl.Rectangle)
	initSprites(&sprites)
	initItems(allItems)


}

update :: proc() {


	rl.BeginDrawing()
	rl.ClearBackground({0, 120, 153, 255})


	rl.BeginMode2D(wCamera)

	//parchment
	for i in 0 ..< 2 {
		for j in 0 ..< 1 {
			rl.DrawTexturePro(
				parchmentTexture,
				rl.Rectangle{0, 0, 1024, 1024},
				rl.Rectangle {
					f32(i) * GRID_SIZE * 4 * 3,
					f32(j) * GRID_SIZE * 4 * 3,
					GRID_SIZE * 4 * 3,
					GRID_SIZE * 4 * 3,
				},
				rl.Vector2{0, 0},
				0,
				rl.WHITE,
			)
		}
	}

	for i in 0 ..= 9 {
		rl.DrawLineEx(
			rl.Vector2{f32(i) * GRID_SIZE, 0},
			rl.Vector2{f32(i) * GRID_SIZE, SCREEN_SIZE.y},
			3 if i % 3 == 0 else 1,
			rl.GRAY,
		)
	}
	for i in 0 ..= 9 {
		rl.DrawLineEx(
			rl.Vector2{0, f32(i) * GRID_SIZE},
			rl.Vector2{SCREEN_SIZE.y, f32(i) * GRID_SIZE},
			3 if i % 3 == 0 else 1,
			rl.GRAY,
		)
	}

	itemClicked := false

	rl.DrawText(
		"Plot the flowing waters",
		i32(9.5 * GRID_SIZE),
		i32(5.3 * GRID_SIZE),
		20,
		rl.BROWN,
	)
	rl.DrawText("Plot the winding roads", i32(9.5 * GRID_SIZE), i32(8.3 * GRID_SIZE), 20, rl.BROWN)
	for item in allItems {
		drawRect := rl.Rectangle{0, 0, GRID_SIZE, GRID_SIZE}
		boundRect := rl.Rectangle{0, 0, GRID_SIZE, GRID_SIZE}
		if item.type == .River {
			if len(item.rules) == 1 {
				continue //skip ends
			}
			drawRect.x = (9.5 + item.hudX) * GRID_SIZE
			drawRect.y = (3.5 + item.hudY) * GRID_SIZE
			boundRect.x = (9 + item.hudX) * GRID_SIZE
			boundRect.y = (3 + item.hudY) * GRID_SIZE
			rl.DrawTexturePro(
				cartTexture,
				sprites[item.spriteName],
				drawRect,
				rl.Vector2{0.5 * GRID_SIZE, 0.5 * GRID_SIZE},
				item.spriteRotatedBy,
				rl.WHITE,
			)
		}

		if item.type == .Road {
			if len(item.rules) == 1 {
				continue //skip ends
			}
			drawRect.x = (9.5 + item.hudX) * GRID_SIZE
			drawRect.y = (6.5 + item.hudY) * GRID_SIZE
			boundRect.x = (9 + item.hudX) * GRID_SIZE
			boundRect.y = (6 + item.hudY) * GRID_SIZE
			rl.DrawTexturePro(
				cartTexture,
				sprites[item.spriteName],
				drawRect,
				rl.Vector2{0.5 * GRID_SIZE, 0.5 * GRID_SIZE},
				item.spriteRotatedBy,
				rl.WHITE,
			)

		}
		if (rl.IsMouseButtonReleased(.LEFT) &&
			   rl.CheckCollisionPointRec(rl.GetMousePosition(), boundRect)) {
			fmt.printfln("Clicked on ", item.spriteName, item.spriteRotatedBy, len(item.rules))
			itemClicked = true
			selectedItem = item
		}
	}

	if (!itemClicked &&
		   rl.IsMouseButtonReleased(.LEFT) &&
		   rl.CheckCollisionPointRec(
			   rl.GetMousePosition(),
			   rl.Rectangle{9 * GRID_SIZE, 3 * GRID_SIZE, 7 * GRID_SIZE, 6 * GRID_SIZE},
		   )) {
		fmt.println("Unselecting item")
		selectedItem = {}
	}

	if len(selectedItem.spriteName) > 0 {
		mouseAt := rl.GetMousePosition()
		drawAt := rl.Rectangle{mouseAt.x, mouseAt.y, GRID_SIZE, GRID_SIZE}
		if (mouseAt.x <= 9 * GRID_SIZE) {
			drawAt.x = math.floor(drawAt.x / GRID_SIZE) * GRID_SIZE + 0.5 * GRID_SIZE
			drawAt.y = math.floor(drawAt.y / GRID_SIZE) * GRID_SIZE + 0.5 * GRID_SIZE

			rl.DrawTexturePro(
				cartTexture,
				sprites[selectedItem.spriteName],
				drawAt,
				rl.Vector2{0.5 * GRID_SIZE, 0.5 * GRID_SIZE},
				selectedItem.spriteRotatedBy,
				rl.ColorAlpha(rl.WHITE, 0.5),
			)
			if rl.IsMouseButtonReleased(.LEFT) {
				x: i32 = i32(math.floor(mouseAt.x / GRID_SIZE))
				y: i32 = i32(math.floor(mouseAt.y / GRID_SIZE))
				itemMap.items[x][y] = selectedItem
				checkItemRules()
			}
		}
	}


	for i in 0 ..< 9 {
		for j in 0 ..< 9 {
			if len(itemMap.items[i][j].spriteName) == 0 {
				continue
			}
			alpha: f32 = 1.0
			if (itemMap.ruleFailed[i][j]) {
				alpha = 0.5
			}
			rl.DrawTexturePro(
				cartTexture,
				sprites[itemMap.items[i][j].spriteName],
				rl.Rectangle {
					(f32(i) + 0.5) * GRID_SIZE,
					(f32(j) + 0.5) * GRID_SIZE,
					GRID_SIZE,
					GRID_SIZE,
				},
				rl.Vector2{0.5 * GRID_SIZE, 0.5 * GRID_SIZE},
				itemMap.items[i][j].spriteRotatedBy,
				rl.ColorAlpha(rl.WHITE, alpha),
			)


		}
	}

	rl.EndMode2D()

	rl.EndDrawing()

	if (rl.IsKeyReleased(rl.KeyboardKey.C)) {
		log.info("C down")
		fmt.printfln("C down")
	}

	// Anything allocated using temp allocator is invalid after this.
	free_all(context.temp_allocator)
}

checkItemRules :: proc() {

	for i in 0 ..< 9 {
		for j in 0 ..< 9 {
			itemMap.ruleFailed[i][j] = false
			item := itemMap.items[i][j]
			if isValidItem(&item) {
				for rule in item.rules {
					ci := i
					cj := j
					switch rule.along {
					case .North:
						cj -= 1
					case .South:
						cj += 1
					case .East:
						ci += 1
					case .West:
						ci -= 1

					}
					if (ci >= 0 && ci < 9 && cj >= 0 && cj < 9) {
						checkItem := itemMap.items[ci][cj]
						if isValidItem(&checkItem) {
							if (checkItem.type != rule.nextTo) {
								itemMap.ruleFailed[i][j] = true
							}
						} else {
							itemMap.ruleFailed[i][j] = true
						}
					}
				}
			}
		}
	}
}

isValidItem :: proc(item: ^Item) -> bool {
	return len(item.spriteName) > 0
}

// In a web build, this is called when browser changes size. Remove the
// `rl.SetWindowSize` call if you don't want a resizable game.
parent_window_size_changed :: proc(w, h: int) {
	rl.SetWindowSize(c.int(w), c.int(h))
}

shutdown :: proc() {
	rl.CloseWindow()
}

should_run :: proc() -> bool {
	when ODIN_OS != .JS {
		// Never run this proc in browser. It contains a 16 ms sleep on web!
		if rl.WindowShouldClose() {
			run = false
		}
	}

	return run
}

