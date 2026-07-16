package game

import rl "vendor:raylib"
import "core:log"
import "core:fmt"
import "core:c"
import b2 "vendor:box2d"

run: bool
roundCat: rl.Texture
longCat: rl.Texture
texture2_rot: f32
worldId: b2.WorldId
bodyId: b2.BodyId
debugDraw: b2.DebugDraw

init :: proc() {
	run = true
	rl.SetConfigFlags({.WINDOW_RESIZABLE, .VSYNC_HINT})
	rl.InitWindow(1280, 720, "Odin + Raylib on the web")

	// Anything in `assets` folder is available to load.
	roundCat = rl.LoadTexture("assets/round_cat.png")

	// A different way of loading a texture: using `read_entire_file` that works
	// both on desktop and web. Note: You can import `core:os` and use
	// `os.read_entire_file`. But that won't work on web. Emscripten has a way
	// to bundle files into the build, and we access those using this
	// special `read_entire_file`.
	if long_cat_data, long_cat_ok := read_entire_file("assets/long_cat.png", context.temp_allocator); long_cat_ok {
		long_cat_img := rl.LoadImageFromMemory(".png", raw_data(long_cat_data), c.int(len(long_cat_data)))
		longCat = rl.LoadTextureFromImage(long_cat_img)
		rl.UnloadImage(long_cat_img)
	}

	worldDef: b2.WorldDef = b2.DefaultWorldDef()
	worldDef.gravity = (b2.Vec2) {0.0, -10.0}
	worldId = b2.CreateWorld(worldDef)

	groundBodyDef : b2.BodyDef = b2.DefaultBodyDef()
	groundBodyDef.position = (b2.Vec2) {0.0, -10.0}

	groundId: b2.BodyId = b2.CreateBody(worldId, groundBodyDef)

	groundBox : b2.Polygon = b2.MakeBox(50, 10)
	groundShapeDef :b2.ShapeDef = b2.DefaultShapeDef()
	_ = b2.CreatePolygonShape(groundId, groundShapeDef, &groundBox)


	bodyDef : b2.BodyDef = b2.DefaultBodyDef()
	bodyDef.type = b2.BodyType.dynamicBody
	bodyDef.position = (b2.Vec2) {0, 4}
	bodyId = b2.CreateBody(worldId, bodyDef)

	dynamicBox:b2.Polygon = b2.MakeBox(1,1)
	shapeDef : b2.ShapeDef = b2.DefaultShapeDef()
	shapeDef.density = 1.0
	shapeDef.material.friction = 0.3
	_ = b2.CreatePolygonShape(bodyId, shapeDef, &dynamicBox)

	debugDraw = raylibDebugDraw()


}

raylibDebugDraw :: proc() -> b2.DebugDraw {
	dDraw : b2.DebugDraw = b2.DefaultDebugDraw()

	return dDraw
}

update :: proc() {
	timeStep : f32 = 1.0 / 60
	subStepCount :i32 = 4

	b2.World_Step(worldId, timeStep, subStepCount)



	rl.BeginDrawing()
	rl.ClearBackground({0, 120, 153, 255})
	{
		texture2_rot += rl.GetFrameTime()*50
		source_rect := rl.Rectangle {
			0, 0,
			f32(longCat.width), f32(longCat.height),
		}

		pos : b2.Vec2 = b2.Body_GetPosition(bodyId)
		log.info("Body at ", pos, timeStep)
		dest_rect := rl.Rectangle {
			pos.x*100, pos.y * 100,
			f32(longCat.width)*5, f32(longCat.height)*5,
		}
		rl.DrawTexturePro(longCat, source_rect, dest_rect, {dest_rect.width/2, dest_rect.height/2}, texture2_rot, rl.WHITE)
	}
	rl.DrawTextureEx(roundCat, rl.GetMousePosition(), 0, 5, rl.WHITE)
	rl.DrawRectangleRec({0, 0, 220, 130}, rl.BLACK)
	rl.GuiLabel({10, 10, 200, 20}, "raygui works!")

	if rl.GuiButton({10, 30, 200, 20}, "Print to log (see console)") {
		log.info("log.info works!")
		fmt.println("fmt.println too.")
	}

	if rl.GuiButton({10, 60, 200, 20}, "Source code (opens GitHub)") {
		rl.OpenURL("https://github.com/karl-zylinski/odin-raylib-web")
	}

	if rl.GuiButton({10, 90, 200, 20}, "Quit") {
		run = false
	}

	b2.World_Draw(worldId, &debugDraw)

	rl.EndDrawing()

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