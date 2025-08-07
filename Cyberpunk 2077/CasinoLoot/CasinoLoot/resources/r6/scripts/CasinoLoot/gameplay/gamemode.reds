

public class gamemode {

    let controller: ref<controller>;

    let panel: ref<inkHorizontalPanel>;
    let panel2: ref<inkHorizontalPanel>;

    let player: ref<GameObject>;
    let bankroll: ref<bankroll>;

    let itemKeys: array<TweakDBID>;

    let kindLabels: array<Int32>;
    let typeLabels: array<Int32>;
    let differentLabels: array<Int32>;
    let pairLabels: array<Int32>;

    let kindPrizes: array<Int32>;
    let typePrizes: array<Int32>;
    let differentPrizes: array<Int32>;
    let pairPrizes: array<Int32>;

    let rewards: array<Int32>;

    let prizeJingles: array<String>;
    let prizeJingle: Int32;

    let prize: Int32;
    let failSound: String;

    let round: Int32;
    let items: array<String>;
    let item: String;

    let TextureParts: array<String>;
    let meleeParts: array<String>;
    let gunParts: array<String>;
    let streakInterface: ref<streak>;

    let itemCategories: array<String>;

    let Resources: array<String>;
    let Parts: array<String>;
    let Colors: array<HDRColor>;
    let theme: array<HDRColor>;

    let meleeKeys: array<String>;
    let gunKeys: array<String>;

    let gameover: Bool;

        let LEGENDARY: Int32;
        let UNCOMMON: Int32;
        let RARE: Int32;
        let EPIC: Int32;
    


    public func OnCreate(
        controller: ref<controller>,
        player: ref<GameObject>
    ) -> Void {


        this.controller = controller;
        this.theme = [
            colors.green(),
            colors.yellowGlow(),
            colors.redGlow(),
            colors.pinkGlow(),
            colors.gray()
        ];

        this.TextureParts = [
            "katana",
            "hammer",
            "knife",
            "revolver_power",
            "shotgun_power",
            "sniper",
            "rifle_preci",
            "subma_power"
        ];

        this.meleeParts = [
            "katana",
            "hammer",
            "knife"
        ];

        this.gunParts = [
            "revolver_power",
            "shotgun_power",
            "sniper",
            "rifle_preci",
            "subma_power"
        ];

        this.itemCategories = [
            "Slash",
            "Blunt",
            "Throw",
            "Pistol",
            "Shotgun",
            "Sniper",
            "Rifle",
            "SMG"
        ];

        this.meleeKeys = [
            "Slash",
            "Blunt",
            "Throw"
        ];

        this.gunKeys = [
            "Pistol",
            "Shotgun",
            "Sniper",
            "Rifle",
            "SMG"
        ];

    this.itemKeys = [
        t"Items.CasinoLoot_SlashToken_COMMON",
        t"Items.CasinoLoot_SlashToken_UNCOMMON",
        t"Items.CasinoLoot_SlashToken_RARE",
        t"Items.CasinoLoot_SlashToken_EPIC",
        t"Items.CasinoLoot_SlashToken_LEGENDARY",

        t"Items.CasinoLoot_BluntToken_COMMON",
        t"Items.CasinoLoot_BluntToken_UNCOMMON",
        t"Items.CasinoLoot_BluntToken_RARE",
        t"Items.CasinoLoot_BluntToken_EPIC",
        t"Items.CasinoLoot_BluntToken_LEGENDARY",

        t"Items.CasinoLoot_ThrowToken_COMMON",
        t"Items.CasinoLoot_ThrowToken_UNCOMMON",
        t"Items.CasinoLoot_ThrowToken_RARE",
        t"Items.CasinoLoot_ThrowToken_EPIC",
        t"Items.CasinoLoot_ThrowToken_LEGENDARY",

        t"Items.CasinoLoot_PistolToken_COMMON",
        t"Items.CasinoLoot_PistolToken_UNCOMMON",
        t"Items.CasinoLoot_PistolToken_RARE",
        t"Items.CasinoLoot_PistolToken_EPIC",
        t"Items.CasinoLoot_PistolToken_LEGENDARY",

        t"Items.CasinoLoot_ShotgunToken_COMMON",
        t"Items.CasinoLoot_ShotgunToken_UNCOMMON",
        t"Items.CasinoLoot_ShotgunToken_RARE",
        t"Items.CasinoLoot_ShotgunToken_EPIC",
        t"Items.CasinoLoot_ShotgunToken_LEGENDARY",

        t"Items.CasinoLoot_SniperToken_COMMON",
        t"Items.CasinoLoot_SniperToken_UNCOMMON",
        t"Items.CasinoLoot_SniperToken_RARE",
        t"Items.CasinoLoot_SniperToken_EPIC",
        t"Items.CasinoLoot_SniperToken_LEGENDARY",

        t"Items.CasinoLoot_RifleToken_COMMON",
        t"Items.CasinoLoot_RifleToken_UNCOMMON",
        t"Items.CasinoLoot_RifleToken_RARE",
        t"Items.CasinoLoot_RifleToken_EPIC",
        t"Items.CasinoLoot_RifleToken_LEGENDARY",

        t"Items.CasinoLoot_SMGToken_COMMON",
        t"Items.CasinoLoot_SMGToken_UNCOMMON",
        t"Items.CasinoLoot_SMGToken_RARE",
        t"Items.CasinoLoot_SMGToken_EPIC",
        t"Items.CasinoLoot_SMGToken_LEGENDARY"
    ];

        this.LEGENDARY = 6;
        this.UNCOMMON = 0;
        this.EPIC = 2;
        this.RARE = 4;

        this.kindPrizes = [10, 25, 50];
        this.typePrizes = [3, 4, 5];
        this.differentPrizes = [1, 777, 777];
        this.pairPrizes = [1, 1, 777];

        this.kindLabels = [25, 18, 9];
        this.typeLabels = [52, 45, 36];
        this.differentLabels = [1, 80, 73];
        this.pairLabels = [1, 1, 64];

        this.prizeJingles = ["dev_vm_processing_shwab_shwab","dev_vm_processing_burrito_xxl", "dev_vm_processing_nicola", "ui_hacking_access_granted", "mq305_sc_04_lab_access_granted", "ui_door_terminal_select"];
        this.failSound = "ui_menu_perk_buy_fail";
        this.prizeJingle = -1;

        this.prize = 0;

        let panelBuilder = new panelBuilder();
        panelBuilder.OnCreate();
        this.panel = panelBuilder.horizontalPanel(this.controller, [1000.0, 0.0], [0.0, 0.0, 950.0, 0.0], [0.0, 0.0], 1, false, false);
        this.controller.addHorizontalPanel(this.panel);
        this.panel2 = panelBuilder.horizontalPanel(this.controller, [1000.0, 0.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0], 1, false, false);
        this.player = this.controller.getPlayer();

        this.items = [];
        this.gameover = false;

        this.Resources = [];
        this.Parts = [];
        this.Colors = this.theme;

        this.round = 0;
        this.controller.wheel().freeSpin(false);

        this.streakInterface = new streak();
        this.streakInterface.OnCreate(this.controller);
        this.streakInterface.displayTitle();

        this.bankroll = new bankroll();
        this.bankroll.OnCreate(this.panel2, this.player, this.controller);
        this.bankroll.Display();

        
    }

    public func bankroll() -> ref<bankroll> {
        return this.bankroll;
    }

    public func setRewards(rewards: array<Int32>) -> Void {
        this.rewards = rewards;
    }

    public func getRound() -> Int32 {
        return this.round;
    }

    public func getRewards() -> array<Int32> {
        return this.rewards;
    }



    public func Play(itemIndex: Int32) -> Void {
        if this.round == 4 || this.gameover { this.Reset(); }

        ArrayPush(this.items, this.itemCategories[itemIndex]);

        ArrayPush(this.Resources, "base\\gameplay\\gui\\common\\icons\\weapon_types.inkatlas");
        ArrayPush(this.Parts, this.TextureParts[itemIndex]);
        ArrayPush(this.Colors, colors.green());

        this.assignScore();

        this.streakInterface.Display(this.Resources, this.Parts, this.Colors);
        this.bankroll.Display();

        //ModLog(n"DEBUG", s"Reward: \(this.items[this.round]) = \(itemIndex)");

        this.giveReward(this.items[this.round]);
           
        this.round += 1;
    }

    public func isGameOver() -> Bool {
        return this.gameover;
    }

    private func playJingle() -> Void {
        if this.prize > 2 {
            this.controller.sound().Play(this.prizeJingles[this.prizeJingle]);
        }
    }

    private func assignScore() -> Void {
        //ModLog(n"DEBUG", s"Round: \(this.round)");

        if this.round > 0 && ArraySize(this.items) > 0 {
            if this.sameWeaponCategory() {
                this.Colors = colors.Set(this.theme, pattern.type(), this.round);
                this.prize = this.typePrizes[this.round-1];
                this.colorJackpot(this.typeLabels[this.round-1]);
            }else if this.sameWeaponKind() {
                this.Colors = colors.Set(this.theme, pattern.kind(), this.round); 
                this.prize = this.kindPrizes[this.round-1];
                this.colorJackpot(this.kindLabels[this.round-1]);
            }else if this.samePairs() {
                this.Colors = colors.Set(this.theme, pattern.pair(), this.round); 
                this.prize = this.pairPrizes[this.round-1];
                this.colorJackpot(this.pairLabels[this.round-1]);
            }else if this.allDifferentWeapons() {
                this.Colors = colors.Set(this.theme, pattern.different(), this.round); 
                this.prize = this.differentPrizes[this.round-1];
                this.colorJackpot(this.differentLabels[this.round-1]);
            }else if this.round == 2 && StrContains(this.items[0], this.items[2]){
                this.Colors = colors.Set(this.theme, pattern.pair(), this.round); 
            }else if this.round > 1 {
                this.Colors = colors.Set(this.theme, pattern.gameover(), this.round); 
                this.controller.sound().Play(this.failSound);
                this.prize = -1;
                this.gameover = true;
            };
        }
    }

    private func colorJackpot(index: Int32) -> Void {
        if this.gameover && index != -1 {
            return;
        }
        //ModLog(n"DEBUG", s"Coloring label: \(index)");
        this.controller.jackpot().Display(index, colors.green());
    }

    private func giveReward(item: String) -> Void {
    
        

            //ModLog(n"DEBUG", s"Prize: \(this.prize)");

            if this.prize == 50 {
                this.prizeJingle = 0;
            }else if this.prize == 25 {
                this.prizeJingle = 1;
            }else if this.prize == 10 {
                this.prizeJingle = 2;
            }else if this.prize == 5 {
                this.prizeJingle = 3;
            }else if this.prize == 4 {
                this.prizeJingle = 4;
            }else if this.prize == 3 {
                this.prizeJingle = 5;  
            }else if this.prize == 777 {
                this.controller.money().Give(this.controller.wheel().getCost());
                this.controller.wheel().freeSpin(true);
                this.controller.getSharedButton(0).resetText();
                this.prize = 1;
            }else {
                this.prize = 1;
            }

            this.playJingle();

            ////ModLog(n"DEBUG", s"Prize 3: \(item)");
            ////ModLog(n"DEBUG", s"Rarity Index: \(this.controller.wheel().getLastPrizeRarity())");

            let rarity = "_COMMON";
            
            if this.controller.wheel().getLastPrizeRarity() == this.UNCOMMON {
                rarity = "UNCOMMON";
            }else if this.controller.wheel().getLastPrizeRarity() == this.RARE {
                rarity = "RARE";
            }else if this.controller.wheel().getLastPrizeRarity() == this.EPIC {
                rarity = "EPIC";
            }else if this.controller.wheel().getLastPrizeRarity() == this.LEGENDARY {
                rarity = "LEGENDARY";
            }

            ////ModLog(n"DEBUG", s"Rarity: \(rarity)");

            let keys = ArraySize(this.itemKeys);
            let key = 0;
            while key < keys {
                let token = this.itemKeys[key];
                let tokenString = TDBID.ToStringDEBUG(token);
                if StrContains(tokenString, rarity) && StrContains(tokenString, item) {
                    ////ModLog(n"DEBUG", s"Token: \(tokenString)");
                    let i: Int32 = 0;
                    while i < this.prize {
                        GameInstance.GetTransactionSystem(this.controller.getPlayer().GetGame()).GiveItem(this.controller.getPlayer(), ItemID.CreateQuery(token), 1);
                        i += 1;
                    }
                }
                key += 1;
            }      
              
    }

    private func setReward(category: String, rarity: String) -> Void {
                        let i = 0;
                while i < ArraySize(this.items) {
                    let item = this.items[i];
                    ////ModLog(n"DEBUG", s"Item: \(item)");
                    ////ModLog(n"DEBUG", s"Last Prize Kind: \(item)");
                    ////ModLog(n"DEBUG", s"Rarity: \(item)");
                    if StrContains(item, this.controller.wheel().getLastPrizeKind()) && StrContains(item, rarity) {
                        this.item = item;
                    }
                }
    }

    private func Reset() -> Void {    
            ////ModLog(n"DEBUG", "Reset");
            this.Resources = [];
            this.Parts = [];
            this.Colors = [];
            this.items = [];
            this.prize = 1;
            this.prizeJingle = -1;
            this.round = 0;
            this.controller.sound().reset();
            this.controller.jackpot().Display(-1, colors.green());
            this.gameover = false;
    }




public func allDifferentWeapons() -> Bool {

    let i = 0;
    let weapons: array<String>;
    let size = ArraySize(this.items);

    if size < 2 {
        ////ModLog(n"DEBUG", s"all different failed, under 3 weapons found");
        return false;
    };

    ////ModLog(n"DEBUG", s"2+ weapons found, checking if all different.");

    while i < size {

        let item = this.items[i];
        if ArrayContains(weapons, item) {
            ////ModLog(n"DEBUG", s"List contains already \(item)");
            return false;
        }

        ////ModLog(n"DEBUG", s"Added to list weapon #\(i): \(item)");
        ArrayPush(weapons, item);
        i += 1;
    };

    return true; 
}

public func sameWeaponKind() -> Bool {

    let size = ArraySize(this.items);

    if size < 2 {
        ////ModLog(n"DEBUG", "Not enough weapons to compare kind.");
        return false;
    }

    let first = this.items[0];
    let i = 1;

    while i < size {
        if !StrContains(this.items[i], first) {
            ////ModLog(n"DEBUG", "Mismatch found: " + this.items[i]);
            return false;
        }
        i += 1;
    }

    ////ModLog(n"DEBUG", "All weapons match: " + first);
    return true;
}


public func samePairs() -> Bool {
    
    let meleeCount = 0;
    let gunCount = 0;
    let x: array<String>;
    let y: array<String>;
    let size = ArraySize(this.items);

    if this.round != 3 {
        return false;
    };

    ////ModLog(n"DEBUG", s"4 weapons found, checking if two pairs.");

    let i = 0;
    while i < size {

        let item = this.items[i];

        if ArrayContains(this.meleeParts, item) {
            ////ModLog(n"DEBUG", s"melee: \(item)");
            meleeCount += 1;
            ArrayPush(x, item);
        } else if ArrayContains(this.gunParts, item) {
            ////ModLog(n"DEBUG", s"gun: \(item)");
            gunCount += 1;
            ArrayPush(y, item);
        }else {
            ////ModLog(n"DEBUG", s"Not melee or a gun: \(item)");
        };

        i += 1;
    };

    if meleeCount == 2 && gunCount == 2 {
        ////ModLog(n"DEBUG", s"Final check");
        if !StrContains(x[0], x[1]) {
            return false;
        }else if !StrContains(y[0], y[1]) {
            return false;
        };
        return true;
    }else {
        ////ModLog(n"DEBUG", s"melee: \(ArraySize(x))");
        ////ModLog(n"DEBUG", s"guns: \(ArraySize(y))");
    };

    return false;
}


public func sameWeaponCategory() -> Bool {
    let size = ArraySize(this.items);

    if size < 2 {
        //ModLog(n"DEBUG", s"Same category failed, under 2 weapons found");
        return false;
    }

   
    //ModLog(n"DEBUG", s"Melee category");
    let allMelee = this.sameCategory(this.meleeKeys);
    //ModLog(n"DEBUG", s"all melee: \(allMelee)");
    //ModLog(n"DEBUG", s"Gun category");
    let allGuns = this.sameCategory(this.gunKeys);
    //ModLog(n"DEBUG", s"all gun: \(allGuns)");


    if allMelee {
        return true;
    } else if allGuns {
        return true;
    }

    return false;
}

public func sameCategory(keys: array<String>) -> Bool {
    let i = 0;
    let weapons: array<String>;
    let same = true;
    let size = ArraySize(this.items);

    if size < 2 {
        //ModLog(n"DEBUG", s"Same category failed, under 2 weapons found");
        return false;
    }

     //ModLog(n"DEBUG", s"2+ weapons found, checking if all same category.");

    while i < size {
        let item = this.items[i];

        if ArrayContains(weapons, item) {
            //ModLog(n"DEBUG", s"List contains already \(item)");
            return false;
        }else if !ArrayContains(keys, item) {
            //ModLog(n"DEBUG", s"List doesn't contains \(item)");
            return false;
        }

        //ModLog(n"DEBUG", s"Added to list weapon #\(i): \(item)");
        ArrayPush(weapons, item);
        i += 1;
    }

    if size != ArraySize(weapons) {
        //ModLog(n"DEBUG", s"The weapons owned(\(size)) and weapon list(\(ArraySize(weapons))) don't match");
        return false;
    }

    return same;
}


}