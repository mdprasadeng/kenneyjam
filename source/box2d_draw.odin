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

drawPolygonFcn :: proc "c" (
	vertices: [^]b2.Vec2,
	vertexCount: i32,
	color: b2.HexColor,
	ctx: rawptr,
) {
	context = runtime.default_context()
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
	rlColor := toRaylibColor(color)
	rl.DrawCircleLinesV(center, radius, rlColor)

}

// Draw a solid circle.
drawSolidCircleFcn :: proc "c" (
	transform: b2.Transform,
	radius: f32,
	color: b2.HexColor,
	ctx: rawptr,
) {
	context = runtime.default_context()
	rlColor := toRaylibColor(color)
	rl.DrawCircleV(transform.p, radius, rlColor)

}

// Draw a solid capsule.
drawSolidCapsuleFcn :: proc "c" (p1, p2: b2.Vec2, radius: f32, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	rlColor := toRaylibColor(color)
	rl.DrawCircleV(p1, radius, rlColor)
	rl.DrawCircleV(p2, radius, rlColor)

	center := b2.Lerp(p1, p2, 0.5)
	delta := b2.Vec2{p2.x - p1.x, p2.y - p1.y}
	length := b2.Length(delta)
	transform := b2.Transform {
		p = center,
		q = {delta.x / length, delta.y / length},
	}

	points: []b2.Vec2 = {
		{-length / 2, radius},
		{-length / 2, -radius},
		{length / 2, -radius},
		{length / 2, radius},
	}

	drawSolidPolygonFcn(transform, &points[0], size_of(points) / size_of(points[0]), 0, color, ctx)

}

// Draw a line segment.
drawSegmentFcn :: proc "c" (p1, p2: b2.Vec2, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	rl.DrawLineV(p1, p2, toRaylibColor(color))

}

AXIS_LENGTH: f32 = 1000.0

// Draw a transform. Choose your own length scale.
drawTransformFcn :: proc "c" (transform: b2.Transform, ctx: rawptr) {
	context = runtime.default_context()
	rlColor := rl.RED

	xVec: b2.Vec2 = {AXIS_LENGTH, 0}
	transformedX := b2.TransformPoint(transform, xVec)
	rl.DrawLineV(transform.p, transformedX, rlColor)

	yVec: b2.Vec2 = {0, AXIS_LENGTH}
	transformedY := b2.TransformPoint(transform, yVec)
	rl.DrawLineV(transform.p, transformedY, rlColor)
}

// Draw a point.
drawPointFcn :: proc "c" (p: b2.Vec2, size: f32, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	rl.DrawCircleV(p, size, toRaylibColor(color))
}

// Draw a string in world space.
drawStringFcn :: proc "c" (p: b2.Vec2, s: cstring, color: b2.HexColor, ctx: rawptr) {
	context = runtime.default_context()
	rl.DrawText(s, i32(p.x), i32(p.y), 16, toRaylibColor(color))
}


raylibDebugDraw :: proc() -> b2.DebugDraw {
	dDraw: b2.DebugDraw = b2.DefaultDebugDraw()
	dDraw.drawShapes = true
	dDraw.drawJoints = true
	// dDraw.drawJointExtras = true
	// dDraw.drawBounds = true
	// dDraw.drawMass = true
	// dDraw.drawBodyNames = true
	// dDraw.drawContacts = true
	// dDraw.drawGraphColors = true
	// dDraw.drawContactNormals = true
	// dDraw.drawContactImpulses = true
	// dDraw.drawContactFeatures = true
	// dDraw.drawFrictionImpulses = true
	// dDraw.drawIslands = true


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

