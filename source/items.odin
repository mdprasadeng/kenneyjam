package game

import "core:fmt"
import rl "vendor:raylib"

initLevels :: proc(level: ^Level) {
	level.name = "Scalopia"

	level.order[0] = {0, 0}
	level.order[1] = {0, 1}
	level.order[2] = {1, 1}
	level.order[3] = {1, 0}
	
	sl: SubLevel = {}
	level.subLevel[0][0].name = "Nyle River"
	level.subLevel[1][0].name = "Chruch of Trader"
	level.subLevel[0][1].name = "City of Calgor"
	level.subLevel[1][1].name = "Planes of Anges"


	level.subLevel[0][0].instructions[0] = "Level 1/4"
	level.subLevel[0][0].instructions[1] = "Click Below and Left to map"
	level.subLevel[0][0].instructions[2] = "Double click to Remove"

	level.subLevel[1][0].instructions[0] = "Level 4/4"
	level.subLevel[1][0].instructions[1] = "Click Below and Left to map"
	level.subLevel[1][0].instructions[2] = "Double click to Remove"

	level.subLevel[0][1].instructions[0] = "Level 2/4"
	level.subLevel[0][1].instructions[1] = "Click Below and Left to map"
	level.subLevel[0][1].instructions[2] = "Double click to Remove"

	level.subLevel[1][1].instructions[0] = "Level 3/4"
	level.subLevel[1][1].instructions[1] = "Click Below and Left to map"
	level.subLevel[1][1].instructions[2] = "Double click to Remove"

	
	//mill, waterWheel, lighthouse, dock
	//chruch, stable, house, castleTall, houseSmall, houses, houseViking, tipi, tent
	
	sl.elements[1][0] = "w1s"
	sl.elements[1][1] = "w2ne"
	sl.elements[2][1] = "w2ew"
	sl.elements[3][1] = "w2ew"
	sl.elements[4][1] = "w2ew"
	sl.elements[5][1] = "w2ew"
	sl.elements[6][1] = "w2ew"
	sl.elements[7][2] = "w3w"
	sl.elements[7][3] = "w2ns"
	sl.elements[7][4] = "w2ns"
	sl.elements[7][5] = "w2ns"
	sl.elements[7][6] = "w2ns"
	sl.elements[6][7] = "w2ew"
	sl.elements[4][7] = "w2es"
	sl.elements[8][2] = "w1w"
	sl.elements[4][8] = "w1n"

	sl.elements[4][2] = "lighthouse"
	sl.elements[7][0] = "waterWheel"
	sl.elements[5][6] = "mill"


	

	sl.elements[0][4] = "r1e"
	
	sl.elements[1][4] = "r2ew"
	sl.elements[2][4] = "r2ew"
	//sl.elements[3][4] = "r2sw"
	sl.elements[4][4] = "house"
	sl.elements[3][5] = "r2ns"
	sl.elements[3][6] = "r2ns"
	sl.elements[3][7] = "r2wn"
	sl.elements[2][7] = "r2ew"
	sl.elements[1][7] = "r2ew"
	sl.elements[1][6] = "stable"
	
	sl.elements[0][7] = "r1e"

	level.subLevel[0][0].elements = sl.elements
	sl = {}
	sl.elements[4][0] = "w1s"
	sl.elements[7][8] = "lighthouse"
	sl.elements[4][8] = "w1n"
	
	sl.elements[0][2] = "r1e"
	sl.elements[7][4] = "houses"
	sl.elements[2][8] = "r1n"


	level.subLevel[0][1].elements = sl.elements
	
	
	sl = {}
	sl.elements[0][2] = "w1e"
	sl.elements[8][4] = "w1w"
	sl.elements[4][8] = "w1n"

	sl.elements[1][5] = "houseViking"
	sl.elements[2][5] = "r1e"
	sl.elements[5][3] = "tipi"
	sl.elements[4][3] = "r1w"
	sl.elements[1][8] = "tent"
	sl.elements[1][7] = "r1e"

	level.subLevel[1][0].elements = sl.elements
	
	
	sl = {}
	sl.elements[4][0] = "w1s"
	sl.elements[8][7] = "w1w"
	sl.elements[6][6] = "w4"
	sl.elements[2][2] = "waterWheel"
	sl.elements[0][5] = "dock"
	sl.elements[2][8] = "lighthouse"

	sl.elements[8][2] = "r1w"
	sl.elements[8][5] = "r1w"
	sl.elements[5][3] = "r4"
	sl.elements[3][6] = "castleTall"
	

	level.subLevel[1][1].elements = sl.elements

	fmt.println("Level init", level.subLevel[0][0].elements[0][0])
}

initSprites :: proc(sprites: ^map[string]rl.Rectangle) {
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
	sprites["treePines"] = rl.Rectangle{128, 1024, 128, 128}
	sprites["treePinesSmall"] = rl.Rectangle{0, 1152, 128, 128}
	sprites["treeTall"] = rl.Rectangle{0, 640, 128, 256}
	sprites["vulcano"] = rl.Rectangle{0, 512, 128, 128}
	sprites["wall"] = rl.Rectangle{384, 128, 128, 128}
	sprites["watchtower"] = rl.Rectangle{384, 0, 128, 128}
	sprites["waterWheel"] = rl.Rectangle{512, 128, 128, 128}
	sprites["well"] = rl.Rectangle{512, 0, 128, 128}
}

initItems :: proc(allItems: ^map[string]Item, randItems: ^[dynamic]string) {
	item: Item

	item = Item{spriteName="treePine", type=.Grass}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="bush", type=.Grass}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="cactusLarge", type=.Grass}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="palm", type=.Grass}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="palmLarge", type=.Grass}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="treePineLarge", type=.Grass}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="treePines", type=.Grass}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="rocks", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="rocksA", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

	item = Item{spriteName="rocksB", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

		item = Item{spriteName="rocksMountain", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

		item = Item{spriteName="rocksTall", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

		item = Item{spriteName="ruins", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

		item = Item{spriteName="skull", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

		item = Item{spriteName="vulcano", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)

		item = Item{spriteName="pyramid", type=.Rock}
	allItems[item.spriteName] = item
	append(randItems, item.spriteName)











	//pathCorner
	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 0,
		type            = .River,
		hudX            = 1,
		hudY            = 0,
	}
	append(&item.rules, ItemRule{.River, .North}, ItemRule{.River, .East})
	allItems["w2ne"] = item

	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 90,
		type            = .River,
		hudX            = 1,
		hudY            = 1,
	}

	append(&item.rules, ItemRule{.River, .East}, ItemRule{.River, .South})
	allItems["w2es"] = item

	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 180,
		type            = .River,
		hudX            = 0,
		hudY            = 1,
	}

	append(&item.rules, ItemRule{.River, .South}, ItemRule{.River, .West})
	allItems["w2sw"] = item

	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 270,
		type            = .River,
		hudX            = 0,
		hudY            = 0,
	}

	append(&item.rules, ItemRule{.River, .West}, ItemRule{.River, .North})
	allItems["w2wn"] = item

	//pathEnd
	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 0,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .North})
	allItems["w1n"] = item

	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 90,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .East})
	allItems["w1e"] = item

	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 180,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .South})
	allItems["w1s"] = item

	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 270,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .West})
	allItems["w1w"] = item

	//pathSplit
	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 0,
		type            = .River,
		hudX            = 2,
		hudY            = 0,
	}

	append(
		&item.rules,
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)
	allItems["w3w"] = item

	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 90,
		type            = .River,
		hudX            = 2,
		hudY            = 1,
	}

	append(&item.rules, ItemRule{.River, .East}, ItemRule{.River, .South}, ItemRule{.River, .West})
	allItems["w3n"] = item

	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 180,
		type            = .River,
		hudX            = 3,
		hudY            = 0,
	}

	append(
		&item.rules,
		ItemRule{.River, .South},
		ItemRule{.River, .West},
		ItemRule{.River, .North},
	)
	allItems["w3e"] = item

	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 270,
		type            = .River,
		hudX            = 3,
		hudY            = 1,
	}

	append(&item.rules, ItemRule{.River, .West}, ItemRule{.River, .North}, ItemRule{.River, .East})
	allItems["w3s"] = item

	//pathStraight	
	item = Item {
		spriteName      = "pathStraight",
		spriteRotatedBy = 0,
		type            = .River,
		hudX            = 4,
		hudY            = 0,
	}

	append(&item.rules, ItemRule{.River, .North}, ItemRule{.River, .South})
	allItems["w2ns"] = item

	item = Item {
		spriteName      = "pathStraight",
		spriteRotatedBy = 90,
		type            = .River,
		hudX            = 4,
		hudY            = 1,
	}

	append(&item.rules, ItemRule{.River, .West}, ItemRule{.River, .East})
	allItems["w2ew"] = item

	//pathCrossing
	item = Item {
		spriteName      = "pathCrossing",
		spriteRotatedBy = 0,
		type            = .River,
		hudX            = 5,
		hudY            = 0,
	}

	append(
		&item.rules,
		ItemRule{.River, .West},
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)
	allItems["w4"] = item

	//arrowCorner
	item = Item {
		spriteName      = "arrowCornerSquare",
		spriteRotatedBy = 0,
		type            = .Road,
		hudX            = 1,
		hudY            = 0,
	}

	append(&item.rules, ItemRule{.Road, .North}, ItemRule{.Road, .East})
	allItems["r2ne"] = item

	item = Item {
		spriteName      = "arrowCornerSquare",
		spriteRotatedBy = 90,
		type            = .Road,
		hudX            = 1,
		hudY            = 1,
	}
	append(&item.rules, ItemRule{.Road, .East}, ItemRule{.Road, .South})
	allItems["r2es"] = item

	item = Item {
		spriteName      = "arrowCornerSquare",
		spriteRotatedBy = 180,
		type            = .Road,
		hudX            = 0,
		hudY            = 1,
	}

	append(&item.rules, ItemRule{.Road, .South}, ItemRule{.Road, .West})
	allItems["r2sw"] = item

	item = Item {
		spriteName      = "arrowCornerSquare",
		spriteRotatedBy = 270,
		type            = .Road,
		hudX            = 0,
		hudY            = 0,
	}

	append(&item.rules, ItemRule{.Road, .West}, ItemRule{.Road, .North})
	allItems["r2wn"] = item

	//arrowEnd
	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 180,
		type            = .Road,
	}
	append(&item.rules, ItemRule{.Road, .North})
	allItems["r1n"] = item

	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 270,
		type            = .Road,
	}
	append(&item.rules, ItemRule{.Road, .East})
	allItems["r1e"] = item

	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 0,
		type            = .Road,
	}
	append(&item.rules, ItemRule{.Road, .South})
	allItems["r1s"] = item

	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 90,
		type            = .Road,
	}
	append(&item.rules, ItemRule{.Road, .West})
	allItems["r1w"] = item

	//arrowSplit
	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 0,
		type            = .Road,
		hudX            = 2,
		hudY            = 0,
	}
	append(&item.rules, ItemRule{.Road, .North}, ItemRule{.Road, .East}, ItemRule{.Road, .South})
	allItems["r3w"] = item

	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 90,
		type            = .Road,
		hudX            = 2,
		hudY            = 1,
	}
	append(&item.rules, ItemRule{.Road, .East}, ItemRule{.Road, .South}, ItemRule{.Road, .West})
	allItems["r3n"] = item

	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 180,
		type            = .Road,
		hudX            = 3,
		hudY            = 0,
	}
	append(&item.rules, ItemRule{.Road, .South}, ItemRule{.Road, .West}, ItemRule{.Road, .North})
	allItems["r3e"] = item

	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 270,
		type            = .Road,
		hudX            = 3,
		hudY            = 1,
	}
	append(&item.rules, ItemRule{.Road, .West}, ItemRule{.Road, .North}, ItemRule{.Road, .East})
	allItems["r3s"] = item

	//arrowStraight	
	item = Item {
		spriteName      = "arrowStraight",
		spriteRotatedBy = 0,
		type            = .Road,
		hudX            = 4,
		hudY            = 0,
	}

	append(&item.rules, ItemRule{.Road, .North}, ItemRule{.Road, .South})
	allItems["r2ns"] = item

	item = Item {
		spriteName      = "arrowStraight",
		spriteRotatedBy = 90,
		type            = .Road,
		hudX            = 4,
		hudY            = 1,
	}

	append(&item.rules, ItemRule{.Road, .West}, ItemRule{.Road, .East})
	allItems["r2ew"] = item

	//arrowCrossing
	item = Item {
		spriteName      = "arrowCrossing",
		spriteRotatedBy = 0,
		type            = .Road,
		hudX            = 5,
		hudY            = 0,
	}

	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems["r4"] = item

	item = Item {
		spriteName = "castleTall",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "church",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "house",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "houseChimney",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "houseSmall",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "houseViking",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "houses",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "tipi",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "tent",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "stable",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "dock",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.River, .West},
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "lighthouse",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.River, .West},
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "waterWheel",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.River, .West},
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)
	allItems[item.spriteName] = item

	item = Item {
		spriteName = "mill",
		type       = .Building,
	}
	append(
		&item.rules,
		ItemRule{.River, .West},
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)
	allItems[item.spriteName] = item
}

