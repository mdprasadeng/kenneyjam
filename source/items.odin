package game

import rl "vendor:raylib"


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

initItems :: proc(allitems: [dynamic]Item) {
	allItems = make([dynamic]Item)
	item: Item

	//pathCorner

	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 0,
		type            = .River,
        hudX = 0,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.River, .North}, ItemRule{.River, .East})


	append(&allItems, item)
	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 90,
		type            = .River,
        hudX = 0,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.River, .East}, ItemRule{.River, .South})

	append(&allItems, item)
	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 180,
		type            = .River,
        hudX = 1,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.River, .South}, ItemRule{.River, .West})

	append(&allItems, item)
	item = Item {
		spriteName      = "pathCorner",
		spriteRotatedBy = 270,
		type            = .River,
        hudX = 1,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.River, .West}, ItemRule{.River, .North})

	//pathEnd
	append(&allItems, item)
	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 0,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .North})

	append(&allItems, item)
	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 90,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .East})

	append(&allItems, item)
	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 180,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .South})

	append(&allItems, item)
	item = Item {
		spriteName      = "pathEnd",
		spriteRotatedBy = 270,
		type            = .River,
	}

	append(&item.rules, ItemRule{.River, .West})

	//pathSplit
	append(&allItems, item)
	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 0,
		type            = .River,
        hudX = 2,
        hudY = 0,
	}

	append(
		&item.rules,
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)

	append(&allItems, item)
	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 90,
		type            = .River,
        hudX = 2,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.River, .East}, ItemRule{.River, .South}, ItemRule{.River, .West})

	append(&allItems, item)
	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 180,
		type            = .River,
        hudX = 3,
        hudY = 0,
	}

	append(
		&item.rules,
		ItemRule{.River, .South},
		ItemRule{.River, .West},
		ItemRule{.River, .North},
	)

	append(&allItems, item)
	item = Item {
		spriteName      = "pathSplit",
		spriteRotatedBy = 270,
		type            = .River,
        hudX = 3,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.River, .West}, ItemRule{.River, .North}, ItemRule{.River, .East})

	//pathStraight	
	append(&allItems, item)
	item = Item {
		spriteName      = "pathStraight",
		spriteRotatedBy = 0,
		type            = .River,
        hudX = 4,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.River, .North}, ItemRule{.River, .South})


	append(&allItems, item)
	item = Item {
		spriteName      = "pathStraight",
		spriteRotatedBy = 90,
		type            = .River,
        hudX = 4,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.River, .West}, ItemRule{.River, .East})

	//pathCrossing
	append(&allItems, item)
	item = Item {
		spriteName      = "pathCrossing",
		spriteRotatedBy = 0,
		type            = .River,
        hudX = 5,
        hudY = 0,
	}

	append(
		&item.rules,
		ItemRule{.River, .West},
		ItemRule{.River, .North},
		ItemRule{.River, .East},
		ItemRule{.River, .South},
	)

	//arrowCorner
	append(&allItems, item)
	item = Item {
		spriteName      = "arrowCorner",
		spriteRotatedBy = 0,
		type            = .Road,
        hudX = 0,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.Road, .North}, ItemRule{.Road, .East})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowCorner",
		spriteRotatedBy = 90,
		type            = .Road,
        hudX = 0,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.Road, .East}, ItemRule{.Road, .South})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowCorner",
		spriteRotatedBy = 180,
		type            = .Road,
        hudX = 1,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.Road, .South}, ItemRule{.Road, .West})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowCorner",
		spriteRotatedBy = 270,
		type            = .Road,
        hudX = 1,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.Road, .West}, ItemRule{.Road, .North})

	//arrowEnd
	append(&allItems, item)
	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 180,
		type            = .Road,
	}

	append(&item.rules, ItemRule{.Road, .North})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 270,
		type            = .Road,
	}

	append(&item.rules, ItemRule{.Road, .East})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 0,
		type            = .Road,
	}

	append(&item.rules, ItemRule{.Road, .South})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowEnd",
		spriteRotatedBy = 90,
		type            = .Road,
	}

	append(&item.rules, ItemRule{.Road, .West})

	//arrowSplit
	append(&allItems, item)
	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 0,
		type            = .Road,
        hudX = 2,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.Road, .North}, ItemRule{.Road, .East}, ItemRule{.Road, .South})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 90,
		type            = .Road,
        hudX = 2,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.Road, .East}, ItemRule{.Road, .South}, ItemRule{.Road, .West})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 180,
		type            = .Road,
        hudX = 3,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.Road, .South}, ItemRule{.Road, .West}, ItemRule{.Road, .North})

	append(&allItems, item)
	item = Item {
		spriteName      = "arrowSplit",
		spriteRotatedBy = 270,
		type            = .Road,
        hudX = 3,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.Road, .West}, ItemRule{.Road, .North}, ItemRule{.Road, .East})

	//arrowStraight	
	append(&allItems, item)
	item = Item {
		spriteName      = "arrowStraight",
		spriteRotatedBy = 0,
		type            = .Road,
        hudX = 4,
        hudY = 0,
	}

	append(&item.rules, ItemRule{.Road, .North}, ItemRule{.Road, .South})


	append(&allItems, item)
	item = Item {
		spriteName      = "arrowStraight",
		spriteRotatedBy = 90,
		type            = .Road,
        hudX = 4,
        hudY = 1,
	}

	append(&item.rules, ItemRule{.Road, .West}, ItemRule{.Road, .East})

	//arrowCrossing
	append(&allItems, item)
	item = Item {
		spriteName      = "arrowCrossing",
		spriteRotatedBy = 0,
		type            = .Road,
        hudX = 5,
        hudY = 0,
	}

	append(
		&item.rules,
		ItemRule{.Road, .West},
		ItemRule{.Road, .North},
		ItemRule{.Road, .East},
		ItemRule{.Road, .South},
	)
	append(&allItems, item)

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
	append(&allItems, item)

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
	append(&allItems, item)

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
	append(&allItems, item)

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
	append(&allItems, item)

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
	append(&allItems, item)

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
	append(&allItems, item)

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
	append(&allItems, item)

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
	append(&allItems, item)

}

