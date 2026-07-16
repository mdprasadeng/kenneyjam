package game

import runtime "base:runtime"
import fmt "core:fmt"
import b2 "vendor:box2d"
import rl "vendor:raylib"

toRaylibColor :: proc(b2Color: b2.HexColor) -> rl.Color {
	b2ColorInt: int = int(b2Color)
	raylibColor: rl.Color = {
		u8((b2ColorInt >> 16) & 255),
		u8((b2ColorInt >> 8) & 255),
		u8((b2ColorInt >> 0) & 255),
		255,
	}
	return raylibColor
}

toRaylibVector2 :: proc(b2Vec: b2.Vec2) -> rl.Vector2 {
	raylibVector2: rl.Vector2 = {b2Vec.x, b2Vec.y}

	return raylibVector2
}

drawPolygonFcn :: proc "c" (vertices: [^]b2.Vec2, vertexCount: i32, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw polygon")
	rlColor: rl.Color = toRaylibColor(color)
	rl.DrawLineStrip(vertices, vertexCount, rlColor)
	rl.DrawLineV(vertices[vertexCount - 1], vertices[0], rlColor)

}

drawSolidPolygonFcn :: proc "c" (
	transform: b2.Transform,
	vertices: [^]b2.Vec2,
	vertexCount: i32,
	radius: f32,
	color: b2.HexColor,
	ctx: rawptr,
) {
	context = runtime.default_context()

	transformedVertices: [dynamic]rl.Vector2
	defer delete(transformedVertices)
	for i: i32 = 0; i < vertexCount; i += 1 {
		tVec := b2.TransformPoint(transform, vertices[vertexCount - 1 - i])
		append(&transformedVertices, tVec)
	}
	append(&transformedVertices, transformedVertices[0])
	rlColor := toRaylibColor(color)
	rl.DrawTriangleStrip(raw_data(transformedVertices), vertexCount + 1, rlColor)
	if (radius > 0) {
		fmt.printfln("Debug draw solid polygon")
	}

}

drawCircleFcn :: proc "c" (center: b2.Vec2, radius: f32, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw circle")

}

// Draw a solid circle.
drawSolidCircleFcn :: proc "c" (transform: b2.Transform, radius: f32, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw solid circle")

}

// Draw a solid capsule.
drawSolidCapsuleFcn :: proc "c" (p1, p2: b2.Vec2, radius: f32, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw solid capsule")

}

// Draw a line segment.
drawSegmentFcn :: proc "c" (p1, p2: b2.Vec2, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw segment")

}

// Draw a transform. Choose your own length scale.
drawTransformFcn :: proc "c" (transform: b2.Transform, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw transform")

}

// Draw a point.
drawPointFcn :: proc "c" (p: b2.Vec2, size: f32, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw point")

}

// Draw a string in world space.
drawStringFcn :: proc "c" (p: b2.Vec2, s: cstring, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	fmt.printfln("Debug draw string")

}


raylibDebugDraw :: proc() -> b2.DebugDraw {
	dDraw: b2.DebugDraw = b2.DefaultDebugDraw()
	dDraw.drawShapes = true
	dDraw.drawJoints = true

	dDraw.DrawPolygonFcn = drawPolygonFcn
	dDraw.DrawSolidPolygonFcn = drawSolidPolygonFcn
	dDraw.DrawCircleFcn = drawCircleFcn
	dDraw.DrawSolidCircleFcn = drawSolidCircleFcn
	dDraw.DrawSolidCapsuleFcn = drawSolidCapsuleFcn
	dDraw.DrawSegmentFcn = drawSegmentFcn
	dDraw.DrawTransformFcn = drawTransformFcn
	dDraw.DrawPointFcn = drawPointFcn
	dDraw.DrawStringFcn = drawStringFcn

	return dDraw
}

