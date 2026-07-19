package game

import "base:builtin"
import "core:c"
import "core:fmt"
import "core:log"
import "core:math"
import "core:math/rand"
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
	items:           [9][9]Item,
	ruleFailed:      [9][9]bool,
	persistentItems: [9][9]bool,
}

SubLevel :: struct {
	name:         cstring,
	instructions: [3]cstring,
	items:        [9][9]Item,
	elements:     [9][9]string,
}

Level :: struct {
	name:     cstring,
	subLevel: [2][2]SubLevel,
	order:    [9][2]int,
}

Screen :: enum {
	START,
	GAME,
	END,
}

screen: Screen
level: Level
currentSubLevel: ^SubLevel
currentSub: int

allItems: map[string]Item
randItems: [dynamic]string

run: bool
cartBlue, cartBrown, cartBlack, cartGreen, parchmentTexture: rl.Texture
wCamera: rl.Camera2D
sprites: map[string]rl.Rectangle
selectedItem: Item = {}
itemMap: ItemMap
riversRuleFailed: bool
roadsRuleFailed: bool
lastClickTime: f64
isMouseDoubleClick: bool
levelWaitTime: f32
levelWaiting: bool
shakeBy: f32 = 0
shakeTime: f32 = -0.7

GRID_SIZE: f32 = 72.0


SCREEN_SIZE := rl.Vector2{16 * GRID_SIZE, 9 * GRID_SIZE}

loadSubLevel :: proc(subLevelIndex: int) {
	levelWaitTime = 3
	levelWaiting = false
	currentSub = subLevelIndex
	if subLevelIndex != 0 {
		prevSubLevel := &level.subLevel[level.order[subLevelIndex - 1][0]][level.order[subLevelIndex - 1][1]]
		prevSubLevel.items = itemMap.items

		for i in 0 ..< 9 {
			for j in 0 ..< 9 {
				if (i > 0 && i < 8 && j > 0 && j < 8) {
					continue
				}
				elem := prevSubLevel.elements[i][j]
				if elem == "r1n" do prevSubLevel.items[i][j] = allItems["r2ns"]
				if elem == "r1s" do prevSubLevel.items[i][j] = allItems["r2ns"]
				if elem == "r1e" do prevSubLevel.items[i][j] = allItems["r2ew"]
				if elem == "r1w" do prevSubLevel.items[i][j] = allItems["r2ew"]

				if elem == "w1n" do prevSubLevel.items[i][j] = allItems["w2ns"]
				if elem == "w1s" do prevSubLevel.items[i][j] = allItems["w2ns"]
				if elem == "w1e" do prevSubLevel.items[i][j] = allItems["w2ew"]
				if elem == "w1w" do prevSubLevel.items[i][j] = allItems["w2ew"]
			}
		}
	}
	fmt.printfln("loading index level", subLevelIndex)
	if subLevelIndex == 4 {
		screen = .END
		return
	}

	currentSubLevel = &level.subLevel[level.order[subLevelIndex][0]][level.order[subLevelIndex][1]]
	itemMap.items = {}
	itemMap.ruleFailed = {}
	itemMap.persistentItems = {}
	roadsRuleFailed = false
	riversRuleFailed = false

	fmt.println("Loading level", currentSubLevel.elements[0][0])

	for i in 0 ..< 9 {
		for j in 0 ..< 9 {
			if len(currentSubLevel.elements[i][j]) > 0 {
				fmt.println("loading level", currentSubLevel.elements[i][j])
				itemMap.items[i][j] = allItems[currentSubLevel.elements[i][j]]
				itemMap.persistentItems[i][j] = true
			}
		}
	}
	checkItemRules()
}

texOf :: proc(item: Item) -> rl.Texture {
	next := item.rules[0].nextTo if len(item.rules) > 0 else .Grass
	if item.type == .River || next == .River do return cartBlue
	if item.type == .Road || next == .Road do return cartBrown
	if item.type == .Grass do return cartGreen

	return cartBlack
}

init :: proc() {
	run = true
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(i32(SCREEN_SIZE.x), i32(SCREEN_SIZE.y), "Odin + Raylib on the web")

	// Anything in `assets` folder is available to load.
	cartBlue = rl.LoadTexture("assets/cart_blue.png")
	cartBlack = rl.LoadTexture("assets/cart_black.png")
	cartGreen = rl.LoadTexture("assets/cart_green.png")
	cartBrown = rl.LoadTexture("assets/cart_brown.png")


	parchmentTexture = rl.LoadTexture("assets/Textures/parchmentCrinkled.png")

	wCamera = rl.Camera2D {
		offset   = rl.Vector2{0, 0},
		target   = rl.Vector2{0, 0},
		zoom     = 1,
		rotation = 0,
	}

	sprites = make(map[string]rl.Rectangle)
	allItems = make(map[string]Item)
	randItems = make([dynamic]string)
	initSprites(&sprites)
	initItems(&allItems, &randItems)
	initLevels(&level)
	loadSubLevel(0)
	checkItemRules()
	screen = .START
}

update :: proc() {
	if screen == .START {
		rl.BeginDrawing()
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
		gSize := i32(GRID_SIZE)
		rl.DrawText("Mapping Scalopia", 4 * gSize, 3 * gSize, 64, rl.BROWN)
		rl.DrawText("Map not to scale", 6 * gSize, 5 * gSize, 24, rl.BROWN)
		rl.DrawText("Click to continue", 6 * gSize, i32(7.5 * GRID_SIZE), 24, rl.BROWN)

		rl.EndMode2D()
		rl.EndDrawing()

		if rl.IsMouseButtonReleased(.LEFT) {
			screen = .GAME
		}
		return
	}


	if screen == .END {
		rl.BeginDrawing()
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
		for x in 0 ..< 2 {
			for y in 0 ..< 2 {
				subLevel := level.subLevel[x][y]
				for i in 0 ..< 9 {
					for j in 0 ..< 9 {
						item := subLevel.items[i][j]
						mainGridSize := GRID_SIZE * 4.5
						subGridSize := mainGridSize / 9.0
						if (len(item.spriteName) == 0) {
							continue
						}
						rl.DrawTexturePro(
							texOf(item),
							sprites[item.spriteName],
							rl.Rectangle {
								f32(x) * mainGridSize + f32(i) * subGridSize + 0.5 * subGridSize,
								f32(y) * mainGridSize + f32(j) * subGridSize + 0.5 * subGridSize,
								subGridSize,
								subGridSize,
							},
							rl.Vector2{subGridSize * 0.5, subGridSize * 0.5},
							item.spriteRotatedBy,
							rl.WHITE,
						)
					}
				}
			}
		}
		gSize := i32(GRID_SIZE)
		rl.DrawText("Scalopia", 10 * gSize, 3 * gSize, 48, rl.BROWN)
		rl.DrawText("Map not to scale", 10 * gSize, 4 * gSize, 24, rl.BROWN)
		rl.DrawText("Click to screenshot", 10 * gSize, i32(5.2 * GRID_SIZE), 24, rl.BROWN)

		rl.EndMode2D()
		rl.EndDrawing()

		if rl.IsMouseButtonReleased(.LEFT) {
			rl.TakeScreenshot("Scalopia.png")
		}
		return
	}

	shakeTime += rl.GetFrameTime()
	if (shakeTime > 0) {
		if (shakeTime < 0.4) {
			shakeBy = rl.Lerp(0, 360, shakeTime / 0.4)
		} else {
			shakeBy = 0
			shakeTime = -1.6
		}
	}


	if (rl.IsKeyReleased(rl.KeyboardKey.SPACE)) {
		levelWaiting = true
	}

	if (levelWaiting) {
		levelWaitTime -= rl.GetFrameTime()
		if (levelWaitTime < 0) {
			currentSub += 1
			loadSubLevel(currentSub)
		} else {
			outer: for i in 0 ..< 9 {
				for j in 0 ..< 9 {
					item := itemMap.items[i][j]
					if !isValidItem(&item) {
						if (rand.int_max(1000) < 3) {
							randItem := rand.choice(randItems[:])
							itemMap.items[i][j] = allItems[randItem]
							break outer
						}
					}
				}
			}

		}
	}


	if rl.IsMouseButtonReleased(.LEFT) {
		currentTime := rl.GetTime()
		if (currentTime - lastClickTime < 0.2) {
			isMouseDoubleClick = true
		} else {
			isMouseDoubleClick = false
		}
		lastClickTime = rl.GetTime()
	}

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
			rl.ColorAlpha(rl.DARKBROWN, 0.3),
		)
	}
	for i in 0 ..= 9 {
		rl.DrawLineEx(
			rl.Vector2{0, f32(i) * GRID_SIZE},
			rl.Vector2{SCREEN_SIZE.y, f32(i) * GRID_SIZE},
			3 if i % 3 == 0 else 1,
			rl.ColorAlpha(rl.DARKBROWN, 0.3),
		)
	}

	itemClicked := false


	riverRuleFailedMsg: cstring = "[]Plot the flowing waters"
	riverRuleDoneMsg: cstring = "[*]Plot the flowing waters"
	roadRuleFailedMsg: cstring = "[]Plot the winding roads"
	roadRuleDoneMsg: cstring = "[*]Plot the winding roads"

	levelName := currentSubLevel.name
	levelInstructions := currentSubLevel.instructions
	rl.DrawText(levelName, i32(10.0 * GRID_SIZE), i32(0.3 * GRID_SIZE), 32, rl.BROWN)
	rl.DrawText(
		levelInstructions[0],
		i32((9.5 + 2.1) * GRID_SIZE),
		i32(0.85 * GRID_SIZE),
		24,
		rl.BROWN,
	)
	rl.DrawText(levelInstructions[1], i32((9.5) * GRID_SIZE), i32(1.3 * GRID_SIZE), 20, rl.BROWN)
	rl.DrawText(levelInstructions[2], i32((9.5) * GRID_SIZE), i32(1.8 * GRID_SIZE), 20, rl.BROWN)
	rl.DrawText(
		riverRuleFailedMsg if riversRuleFailed else riverRuleDoneMsg,
		i32(9.5 * GRID_SIZE),
		i32(5.3 * GRID_SIZE),
		20,
		rl.BLUE,
	)
	rl.DrawText(
		roadRuleFailedMsg if roadsRuleFailed else roadRuleDoneMsg,
		i32(9.5 * GRID_SIZE),
		i32(8.3 * GRID_SIZE),
		20,
		rl.MAROON,
	)
	for _, item in allItems {
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
				texOf(item),
				sprites[item.spriteName],
				drawRect,
				rl.Vector2{0.5 * GRID_SIZE, 0.5 * GRID_SIZE},
				item.spriteRotatedBy,
				rl.WHITE,
			)
		} else if item.type == .Road {
			if len(item.rules) == 1 {
				continue //skip ends
			}
			drawRect.x = (9.5 + item.hudX) * GRID_SIZE
			drawRect.y = (6.5 + item.hudY) * GRID_SIZE
			boundRect.x = (9 + item.hudX) * GRID_SIZE
			boundRect.y = (6 + item.hudY) * GRID_SIZE
			rl.DrawTexturePro(
				texOf(item),
				sprites[item.spriteName],
				drawRect,
				rl.Vector2{0.5 * GRID_SIZE, 0.5 * GRID_SIZE},
				item.spriteRotatedBy,
				rl.WHITE,
			)

		} else {
			continue
		}

		if (rl.CheckCollisionPointRec(rl.GetMousePosition(), boundRect)) {
			rl.DrawRectangleLinesEx(boundRect, 3, rl.ColorAlpha(rl.DARKBROWN, 0.5))
		}

		if (rl.IsMouseButtonReleased(.LEFT) &&
			   rl.CheckCollisionPointRec(rl.GetMousePosition(), boundRect)) {
			fmt.printfln("Clicked on ", item.spriteName, item.spriteRotatedBy, len(item.rules))
			itemClicked = true
			selectedItem = item
			rl.DrawRectangleRec(boundRect, rl.ColorAlpha(rl.DARKBROWN, 0.5))
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
		drawAt := rl.Rectangle{mouseAt.x, mouseAt.y, GRID_SIZE * 1.2, GRID_SIZE * 1.2}
		if (mouseAt.x <= 9 * GRID_SIZE) {
			drawAt.x = math.floor(drawAt.x / GRID_SIZE) * GRID_SIZE + 0.5 * GRID_SIZE
			drawAt.y = math.floor(drawAt.y / GRID_SIZE) * GRID_SIZE + 0.5 * GRID_SIZE

			rl.DrawTexturePro(
				texOf(selectedItem),
				sprites[selectedItem.spriteName],
				drawAt,
				rl.Vector2{0.6 * GRID_SIZE, 0.6 * GRID_SIZE},
				selectedItem.spriteRotatedBy,
				rl.ColorAlpha(rl.WHITE, 0.5),
			)
			if rl.IsMouseButtonReleased(.LEFT) {
				x: i32 = i32(math.floor(mouseAt.x / GRID_SIZE))
				y: i32 = i32(math.floor(mouseAt.y / GRID_SIZE))
				if !itemMap.persistentItems[x][y] {
					itemMap.items[x][y] = selectedItem
					checkItemRules()
				}
			}
		}
	}

	if (rl.IsMouseButtonReleased(.LEFT) && isMouseDoubleClick) {
		mouseAt := rl.GetMousePosition()
		if (mouseAt.x <= 9 * GRID_SIZE) {
			x: i32 = i32(math.floor(mouseAt.x / GRID_SIZE))
			y: i32 = i32(math.floor(mouseAt.y / GRID_SIZE))

			if (!itemMap.persistentItems[x][y] && isValidItem(&itemMap.items[x][y])) {

				itemMap.items[x][y] = {}
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
			rotateBy: f32 = itemMap.items[i][j].spriteRotatedBy
			if (itemMap.ruleFailed[i][j]) {
				alpha = 0.6
				rotateBy += shakeBy
			}
			rl.DrawTexturePro(
				texOf(itemMap.items[i][j]),
				sprites[itemMap.items[i][j].spriteName],
				rl.Rectangle {
					(f32(i) + 0.5) * GRID_SIZE,
					(f32(j) + 0.5) * GRID_SIZE,
					GRID_SIZE,
					GRID_SIZE,
				},
				rl.Vector2{0.5 * GRID_SIZE, 0.5 * GRID_SIZE},
				rotateBy,
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

	riversRuleFailed = false
	roadsRuleFailed = false
	for i in 0 ..< 9 {
		for j in 0 ..< 9 {
			itemMap.ruleFailed[i][j] = false
			item := itemMap.items[i][j]
			if isValidItem(&item) {
				if item.type == .Building {
					ruleFailed := true
					type := item.rules[0].nextTo

					if i > 0 {
						if isValidItem(&itemMap.items[i - 1][j]) && itemMap.items[i - 1][j].type == type do ruleFailed = false
					}
					if i < 8 {
						if isValidItem(&itemMap.items[i + 1][j]) && itemMap.items[i + 1][j].type == type do ruleFailed = false
					}
					if j > 0 {
						if isValidItem(&itemMap.items[i][j - 1]) && itemMap.items[i][j - 1].type == type do ruleFailed = false
					}
					if j < 8 {
						if isValidItem(&itemMap.items[i][j + 1]) && itemMap.items[i][j + 1].type == type do ruleFailed = false
					}


					if (ruleFailed == true) {
						itemMap.ruleFailed[i][j] = true
						if type == .River {
							riversRuleFailed = true
						}
						if type == .Road {
							roadsRuleFailed = true
						}
					}
					continue
				}
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
							rDir: Direction
							switch (rule.along) {
							case .North:
								rDir = .South
							case .South:
								rDir = .North
							case .East:
								rDir = .West
							case .West:
								rDir = .East
							}
							cruleRDir: ItemRule
							foundRRule := false
							for crule in checkItem.rules {
								if (crule.along == rDir) {
									cruleRDir = crule
									foundRRule = true
								}
							}
							if (checkItem.type != rule.nextTo ||
								   !foundRRule ||
								   (cruleRDir.nextTo != checkItem.type)) {
								itemMap.ruleFailed[i][j] = true
								if rule.nextTo == .River {
									riversRuleFailed = true
								}
								if rule.nextTo == .Road {
									roadsRuleFailed = true
								}
							}
						} else {
							itemMap.ruleFailed[i][j] = true
							if rule.nextTo == .River {
								riversRuleFailed = true
							}
							if rule.nextTo == .Road {
								roadsRuleFailed = true
							}
						}
					} else {
						itemMap.ruleFailed[i][j] = true
						if rule.nextTo == .River {
							riversRuleFailed = true
						}
						if rule.nextTo == .Road {
							roadsRuleFailed = true
						}
					}
				}
			}
		}
	}

	if (!riversRuleFailed && !roadsRuleFailed) {
		levelWaiting = true
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

