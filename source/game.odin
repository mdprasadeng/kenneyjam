package game

import "core:c"
import "core:fmt"
import "core:log"
import b2 "vendor:box2d"
import rl "vendor:raylib"


run: bool
cartTexture, parchmentTexture: rl.Texture
worldId: b2.WorldId
bodyId: b2.BodyId
debugDraw: b2.DebugDraw
b2Camera: rl.Camera2D
wCamera: rl.Camera2D
sprites: map[string]rl.Rectangle

GRID_SIZE: f32 = 128.0


SCREEN_SIZE := rl.Vector2{16 * GRID_SIZE, 9 * GRID_SIZE}

init :: proc() {
	run = true
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(i32(SCREEN_SIZE.x), i32(SCREEN_SIZE.y), "Odin + Raylib on the web")

	// Anything in `assets` folder is available to load.
	cartTexture = rl.LoadTexture("assets/spritesheet_retina.png")
	parchmentTexture = rl.LoadTexture("assets/Textures/parchmentCrinkled.png")
	rl.SetTextureWrap(cartTexture, .REPEAT)

	wCamera = rl.Camera2D {
		offset   = rl.Vector2{0, 0},
		target   = rl.Vector2{0, 0},
		zoom     = 1,
		rotation = 0,
	}

	sprites = make(map[string]rl.Rectangle)
	sprites["arrowCorner"] = rl.Rectangle{512, 1152, 128, 128}
	sprites["arrowCornerSquare"] = rl.Rectangle{1024, 1152, 128, 128}
	sprites["arrowCrossing"] = rl.Rectangle{1024, 1024, 128, 128}
	sprites["arrowEnd"] = rl.Rectangle{1024, 896, 128, 128}
	sprites["arrowHead"] = rl.Rectangle{1024, 768, 128, 128}
	sprites["arrowSmall"] = rl.Rectangle{1024, 640, 128, 128}
	sprites["arrowSplit"] = rl.Rectangle{1024, 512, 128, 128}
	sprites["arrowStraight"] = rl.Rectangle{1024, 384, 128, 128}
	sprites["banner"] = rl.Rectangle{1024, 256, 128, 128}
	sprites["bridge"] = rl.Rectangle{1024, 128, 128, 128}
	sprites["bridgeRope"] = rl.Rectangle{1024, 0, 128, 128}
	sprites["bush"] = rl.Rectangle{896, 1152, 128, 128}
	sprites["cactus"] = rl.Rectangle{896, 1024, 128, 128}
	sprites["cactusLarge"] = rl.Rectangle{896, 896, 128, 128}
	sprites["campfire"] = rl.Rectangle{896, 768, 128, 128}
	sprites["castle"] = rl.Rectangle{896, 640, 128, 128}
	sprites["castleTall"] = rl.Rectangle{896, 512, 128, 128}
	sprites["castleWide"] = rl.Rectangle{0, 0, 256, 128}
	sprites["castleWideLow"] = rl.Rectangle{0, 128, 256, 128}
	sprites["chest"] = rl.Rectangle{896, 128, 128, 128}
	sprites["church"] = rl.Rectangle{896, 0, 128, 128}
	sprites["churchLarge"] = rl.Rectangle{768, 1152, 128, 128}
	sprites["compass"] = rl.Rectangle{768, 1024, 128, 128}
	sprites["dock"] = rl.Rectangle{768, 896, 128, 128}
	sprites["elementCircle"] = rl.Rectangle{768, 768, 128, 128}
	sprites["elementCross"] = rl.Rectangle{768, 640, 128, 128}
	sprites["elementDiamond"] = rl.Rectangle{768, 512, 128, 128}
	sprites["elementShield"] = rl.Rectangle{768, 384, 128, 128}
	sprites["elementSquare"] = rl.Rectangle{768, 256, 128, 128}
	sprites["fence"] = rl.Rectangle{768, 128, 128, 128}
	sprites["flag"] = rl.Rectangle{768, 0, 128, 128}
	sprites["gate"] = rl.Rectangle{640, 1152, 128, 128}
	sprites["graveyard"] = rl.Rectangle{640, 1024, 128, 128}
	sprites["house"] = rl.Rectangle{640, 896, 128, 128}
	sprites["houseChimney"] = rl.Rectangle{640, 768, 128, 128}
	sprites["houseSmall"] = rl.Rectangle{640, 512, 128, 128}
	sprites["houseTall"] = rl.Rectangle{640, 384, 128, 128}
	sprites["houseViking"] = rl.Rectangle{640, 256, 128, 128}
	sprites["houses"] = rl.Rectangle{640, 640, 128, 128}
	sprites["lake"] = rl.Rectangle{0, 256, 256, 128}
	sprites["lakeRound"] = rl.Rectangle{0, 384, 256, 128}
	sprites["lighthouse"] = rl.Rectangle{1152, 0, 128, 128}
	sprites["mill"] = rl.Rectangle{512, 1024, 128, 128}
	sprites["mine"] = rl.Rectangle{512, 896, 128, 128}
	sprites["palm"] = rl.Rectangle{512, 768, 128, 128}
	sprites["palmLarge"] = rl.Rectangle{512, 640, 128, 128}
	sprites["pathCorner"] = rl.Rectangle{512, 512, 128, 128}
	sprites["pathCrossing"] = rl.Rectangle{512, 384, 128, 128}
	sprites["pathEnd"] = rl.Rectangle{512, 256, 128, 128}
	sprites["pathSplit"] = rl.Rectangle{896, 256, 128, 128}
	sprites["pathStraight"] = rl.Rectangle{896, 384, 128, 128}
	sprites["pyramid"] = rl.Rectangle{384, 1152, 128, 128}
	sprites["rocks"] = rl.Rectangle{384, 1024, 128, 128}
	sprites["rocksA"] = rl.Rectangle{384, 896, 128, 128}
	sprites["rocksB"] = rl.Rectangle{384, 768, 128, 128}
	sprites["rocksMountain"] = rl.Rectangle{384, 640, 128, 128}
	sprites["rocksTall"] = rl.Rectangle{384, 512, 128, 128}
	sprites["ruins"] = rl.Rectangle{384, 384, 128, 128}
	sprites["ship"] = rl.Rectangle{384, 256, 128, 128}
	sprites["skull"] = rl.Rectangle{640, 0, 128, 128}
	sprites["stable"] = rl.Rectangle{640, 128, 128, 128}
	sprites["tent"] = rl.Rectangle{256, 1152, 128, 128}
	sprites["textureBricks"] = rl.Rectangle{256, 1024, 128, 128}
	sprites["textureStone"] = rl.Rectangle{256, 896, 128, 128}
	sprites["textureWater"] = rl.Rectangle{256, 768, 128, 128}
	sprites["tipi"] = rl.Rectangle{256, 640, 128, 128}
	sprites["tower"] = rl.Rectangle{256, 512, 128, 128}
	sprites["towerLow"] = rl.Rectangle{256, 384, 128, 128}
	sprites["towerTall"] = rl.Rectangle{256, 256, 128, 128}
	sprites["towerWatch"] = rl.Rectangle{256, 128, 128, 128}
	sprites["treePine"] = rl.Rectangle{256, 0, 128, 128}
	sprites["treePineLarge"] = rl.Rectangle{128, 1152, 128, 128}
	sprites["treePineTall"] = rl.Rectangle{128, 768, 128, 256}
	sprites["treePineTallLarge"] = rl.Rectangle{128, 512, 128, 256}
	sprites["treePineTallLow"] = rl.Rectangle{0, 896, 128, 256}
	sprites["treePines"] = rl.Rectangle{128, 1024, 128, 128}
	sprites["treePinesSmall"] = rl.Rectangle{0, 1152, 128, 128}
	sprites["treeTall"] = rl.Rectangle{0, 640, 128, 256}
	sprites["vulcano"] = rl.Rectangle{0, 512, 128, 128}
	sprites["wall"] = rl.Rectangle{384, 128, 128, 128}
	sprites["watchtower"] = rl.Rectangle{384, 0, 128, 128}
	sprites["waterWheel"] = rl.Rectangle{512, 128, 128, 128}
	sprites["well"] = rl.Rectangle{512, 0, 128, 128}
}

update :: proc() {


	rl.BeginDrawing()
	rl.ClearBackground({0, 120, 153, 255})


	rl.BeginMode2D(wCamera)

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


	rl.DrawTexturePro(
		cartTexture,
		sprites["compass"],
		rl.Rectangle{SCREEN_SIZE.x - GRID_SIZE * 3, 0, GRID_SIZE * 3, GRID_SIZE * 3},
		rl.Vector2{0, 0},
		0,
		rl.WHITE,
	)
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
	// rl.DrawTexture(cartTexture, 100, 100, rl.WHITE)
	rl.EndMode2D()

	rl.EndDrawing()

	if (rl.IsKeyReleased(rl.KeyboardKey.C)) {
		log.info("C down")
		fmt.printfln("C down")
	}

	// Anything allocated using temp allocator is invalid after this.
	free_all(context.temp_allocator)
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

