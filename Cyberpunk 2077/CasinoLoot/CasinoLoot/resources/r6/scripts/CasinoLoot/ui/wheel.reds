import Codeware.UI.*
import Audioware.*

public class wheel {
    
    let controller: ref<controller>;

    let Canvas: ref<inkCanvas>;
    let canvasImage: ref<inkImage>;
    let canvasArrow: ref<inkImage>;
    let canvasIcons: array<ref<inkImage>>;

    let texturePart: String;
    
    let iconColor: HDRColor;

    let spinButton: ref<spinButton>;
    let spinSound: CName;

    let panel: ref<inkCompoundWidget>;
    let panelArrow: ref<inkCompoundWidget>;
    let player: ref<GameObject>;

    let TextureParts: array<String>;

    let lastPrizeIndex: Int32;
    let prizeIndex: Int32;
    let winStreak: Int32;
    let prizeHistory: array<ItemID>;
    let round: Int32;

    let spun: Bool;
    let free: Bool;
    let itemPool: array<Int32>;
    let segmentIndex: Int32;

    let firstSpin: Bool;

    let autoButton: ref<checkbox>;
    let auto: Bool;
    let idled: Bool;

    public func OnCreate(controller: ref<controller>, gamemode: ref<gamemode>) -> Void {
        this.controller = controller;
        let panelBuilder = new panelBuilder();
        panelBuilder.OnCreate();

        
        this.auto = false;

        this.spun = false;
        this.free = false;

        this.generatePrizeIndex();

        
        this.panelArrow = panelBuilder.horizontalPanel(this.controller, [3000.0, 75.0], [0.0, 90.0, 0.0, 0.0], [0.5, 0.5], 2, true, false);
        this.panel = panelBuilder.verticalPanel(this.controller, [2600.0, 1000.0], [0.0, 0.0, 0.0, 0.0], [0.5, 0.5], 3, true, true);

        this.player = this.controller.getPlayer();
        this.winStreak = 0;
        this.iconColor = colors.yellowGlow();

        this.firstSpin = true;

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

        this.Canvas = new inkCanvas();
        this.canvasImage = new inkImage();
        this.canvasArrow = new inkImage();

        this.Initialize();
        this.idled = false;
    }

    private func Initialize() -> Void {
        this.createCanvas();
        this.addCanvasImage();
        this.addIcons();
        this.addArrow();
        this.addSpinButton();
        this.addAutoButton();
    }

    private func createCanvas() -> Void {
        this.Canvas.SetName(n"Gachaloot_Wheel");
        this.Canvas.SetSize(new Vector2(1024.0, 1024.0));
        this.Canvas.SetAnchor(inkEAnchor.Centered);
        this.Canvas.SetAnchorPoint(new Vector2(0.0, -0.25));
        this.Canvas.SetHAlign(inkEHorizontalAlign.Center);
        this.Canvas.SetVAlign(inkEVerticalAlign.Center);
        this.Canvas.SetInteractive(false);
        this.Canvas.Reparent(this.panel);
    }

    public func updateIconsColor(colors: array<HDRColor>) -> Void {
        let i = 0;
        while i < ArraySize(this.canvasIcons) {
            let item = this.canvasIcons[i];
            let color = colors[i];
            item.SetTintColor(color);
            item.Reparent(this.Canvas);
        }
    }

    private func addCanvasImage() -> Void {
        this.canvasImage.SetName(n"Gachaloot_Wheel_Image");
        this.canvasImage.SetSize(new Vector2(1024.0, 1024.0));
        this.canvasImage.SetAnchor(inkEAnchor.Fill);
        this.canvasImage.SetAnchorPoint(new Vector2(0.5, 0.5));
        this.canvasImage.SetHAlign(inkEHorizontalAlign.Center);
        this.canvasImage.SetVAlign(inkEVerticalAlign.Center);
        this.canvasImage.SetNineSliceScale(false); // optional, depends on asset
        this.canvasImage.SetInteractive(false);
        this.canvasImage.SetAtlasResource(r"base\\gameplay\\gui\\widgets\\gachaloot_wheel.inkatlas");
        this.canvasImage.SetTexturePart(n"gachaloot_wheel");
        this.canvasImage.SetRotation(25.0);
        this.canvasImage.Reparent(this.Canvas);
    }

private func ShuffledIndexes() -> array<Int32> {
    let rewards: array<Int32>;
    let pool: array<Int32> = [0, 1, 2, 3, 4, 5, 6, 7];
    let count = ArraySize(pool);

    let i = 0;
    while ArraySize(pool) > 0 {
        let index = RandRange(0, ArraySize(pool) - 1);
        ArrayPush(rewards, pool[index]);
        ArrayErase(pool, index);
    };

    this.controller.gamemode().setRewards(rewards);
    this.itemPool = rewards;

    return rewards;
}



    private func addIcons() -> Void {

    //modlog(n"DEBUG", s"Prize index: \(this.prizeIndex), prize item: \(this.TextureParts[this.prizeIndex])");
//modlog(n"DEBUG", s"Item pool: \(this.itemPool)");
//modlog(n"DEBUG", s"Segment index on wheel: \(this.segmentIndex)");
//modlog(n"DEBUG", s"Item at segment index: \(this.TextureParts[this.itemPool[this.segmentIndex]])");


        this.Canvas.RemoveAllChildren();
        this.addCanvasImage();
        let numSegments = 8;
        let radius = 320.0;
        let angleStep = 360.0 / Cast<Float>(numSegments);

        //if !this.firstSpin { this.generatePrizeIndex(); }

        let i = 0;
        while i < numSegments {
            ////modlog(n"DEBUG", s"Shuffled: \(this.itemPool[i]) = \(this.TextureParts[this.itemPool[i]])");
            this.texturePart = this.TextureParts[this.itemPool[i]];
 
                let angleRad = Deg2Rad(angleStep * Cast<Float>(i));
                
                let x = radius * CosF(angleRad);
                let y = radius * SinF(angleRad);

                let icon: ref<inkImage> = new inkImage();
                icon.SetName(StringToName("SegmentIcon" + ToString(i)));
                icon.SetAtlasResource(ResRef.FromString("base\\gameplay\\gui\\common\\icons\\weapon_types.inkatlas"));
                icon.SetTexturePart(StringToName(this.texturePart));
                icon.SetSize(250.0, 75.0);
                icon.SetAnchor(inkEAnchor.Centered);
                icon.SetAnchorPoint(new Vector2(0.5, 0.5));
                icon.SetHAlign(inkEHorizontalAlign.Center);
                icon.SetVAlign(inkEVerticalAlign.Center);
                icon.SetMargin(new inkMargin(x, y, 0.0, 0.0));
                icon.SetFitToContent(false);
                icon.SetRotation(45.0 * Cast<Float>(i));
                icon.SetScale(new Vector2(0.9,0.9));

                if this.segmentIndex == i && !this.firstSpin && !this.spun {  
                    icon.SetTintColor(colors.yellowGlow());
                }
                else if i % 2 == 0 {
                    icon.SetTintColor(colors.black());
                }else {
                    icon.SetTintColor(colors.white());
                }
                 
                icon.Reparent(this.Canvas);
                ArrayPush(this.canvasIcons, icon);  
    

            i += 1;
        }
    }

    

    public func freeSpin(isfree: Bool) -> Void {
		this.free = isfree;
	}

	public func isFree() -> Bool {
		return this.free;
	}

    public func getCost() -> Int32 {
        return 5000;
    }

    public func setIconColor(color: HDRColor) -> Void {
        this.iconColor = color;
    }

    public func getLastPrizeKind() -> String {
        return this.TextureParts[this.lastPrizeIndex];
    }

    public func getLastPrizeRarity() -> Int32 {
        return this.segmentIndex;
    }

    private func addArrow() -> Void {
        this.canvasArrow.SetName(n"PointerArrow");
        this.canvasArrow.SetAtlasResource(r"base\\gameplay\\gui\\common\\icons\\braindance_icons.inkatlas");
        this.canvasArrow.SetTexturePart(n"back_indicator"); 
        this.canvasArrow.SetSize(new Vector2(70.0, 70.0));
        this.canvasArrow.SetAnchor(inkEAnchor.CenterRight);
        this.canvasArrow.SetRotation(90.0);
        this.canvasArrow.SetHAlign(inkEHorizontalAlign.Right);
        this.canvasArrow.SetVAlign(inkEVerticalAlign.Center);
        this.canvasArrow.SetTintColor(colors.mint());
        this.canvasArrow.SetMargin(new inkMargin(0.0, 0.0, 0.0, 0.0));
        this.canvasArrow.Reparent(this.panelArrow);
    }

    private func addSpinButton() -> Void {
        this.spinButton = spinButton.Create(this.player, this.controller);
        this.controller.addSharedButton(this.spinButton);
        this.controller.money().isBrokeboi();
        this.spinButton.ToggleAnimations(true);
        this.spinButton.ToggleSounds(true);
        this.spinButton.Reparent(this.panel);
        this.spinButton.RegisterToCallback(n"OnBtnClick", this, n"OnSpinClicked");
    }

    private func addAutoButton() -> Void {
        this.autoButton = checkbox.Create(this.controller, this.panel);
        this.autoButton.RegisterToCallback(n"OnBtnClick", this, n"OnAutoClicked");
    }

    public func generatePrizeIndex() -> Int32 {
        this.ShuffledIndexes();
        let roll: Float = RandF(); 
        this.prizeIndex = FloorF(roll * 8.0);
        this.lastPrizeIndex = this.prizeIndex;
        ////modlog(n"DEBUG", s"Current prize: \(this.prizeIndex)");
        ////modlog(n"DEBUG", s"REWARD INDEX: \(this.FindIndex(this.itemPool, this.prizeIndex))");
    }

    func FindIndex(arr: array<Int32>, value: Int32) -> Int32 {
        let i = 0;
        while i < ArraySize(arr) {
            if arr[i] == value {
                return i;
            };
            i += 1;
        };
        return -1; // Not found
    }

    public func getSegmentIndex() -> Int32 {
        return this.segmentIndex;
    }

    public func idleFix() -> Void {
        if this.auto && !this.controller.page().showSite {
            this.idled = true;
        }else if this.auto && this.idled && this.controller.page().showSite {
            this.idled = false;
            this.auto = false;
            this.controller.gamemode.Reset();
        }
    }

    private func spinWheel() -> Void {
        //ModLog(n"DEBUG", s"\(this.controller.page().showSite)");

        this.idleFix();

        this.spinButton.ApplyDisabled();
        this.spun = true;
        this.Pay();
        if !this.firstSpin { this.generatePrizeIndex(); }

        let numSegments: Int32 = 8;
        let degreesPerPrize: Float = 360.0 / 8.0; // 45° per segment
        let visualTopAngle: Float = 270.0;        // Top of the wheel

        // Find where in the wheel layout your reward is
        this.segmentIndex = this.FindIndex(this.itemPool, this.prizeIndex);

        ////modlog(n"DEBUG", s"Segment Index on Wheel: \(this.segmentIndex)");

        // That segment is located at this angle
        let prizeAngle: Float = Cast<Float>(this.segmentIndex) * degreesPerPrize;

        ////modlog(n"DEBUG", s"PrizeAngle: \(prizeAngle)");

        // Calculate total spin: full rotations + spin to align prize to top
        let totalSpin: Float = (360.0 * 4.0) + ((visualTopAngle - prizeAngle + 360.0) % 360.0);



        let anim: ref<inkAnimRotation> = new inkAnimRotation();
        anim.SetStartRotation(0.0);
        anim.SetEndRotation(totalSpin);
        anim.SetGoShortPath(false);
        anim.SetDuration(4.0);
        anim.SetMode(inkanimInterpolationMode.EasyOut);

        let def: ref<inkAnimDef> = new inkAnimDef();
        def.AddInterpolator(anim);

        let proxy: ref<inkAnimProxy> = this.Canvas.PlayAnimation(def);
        proxy.RegisterToCallback(inkanimEventType.OnFinish, this, n"OnSpinFinished");
        proxy.RegisterToCallback(inkanimEventType.OnStart, this, n"OnSpinStarted");
    }

    private func Pay() -> Void {
        this.controller.money().Remove(this.getCost());
    }

    private cb func OnAutoClicked(evt: ref<inkCustomEvent>) -> Bool {
        this.auto = !this.auto;
        //ModLog(n"DEBUG", s"Auto: \(this.auto)");
        if this.auto {
            this.autoButton.attachImage(n"on");
            return true;
        }else {
            this.autoButton.attachImage(n"off");
        }
        return false;
    }

    private cb func OnSpinClicked(evt: ref<inkCustomEvent>) -> Bool {
        ////modlog(n"DEBUG", s"Spin Clicked");
        if !this.controller.money().isBrokeboi() && !this.spun {
            ////modlog(n"DEBUG", s"Spin Clicked 2");
            this.spinWheel();
            return true;
        } 
        return false;
    }



    private cb func OnSpinStarted(animProxy: ref<inkAnimProxy>) {
        //modlog(n"DEBUG", s"Prize index: \(this.prizeIndex), prize item: \(this.TextureParts[this.prizeIndex])");
//modlog(n"DEBUG", s"Item pool: \(this.itemPool)");
//modlog(n"DEBUG", s"Segment index on wheel: \(this.segmentIndex)");
//modlog(n"DEBUG", s"Item at segment index: \(this.TextureParts[this.itemPool[this.segmentIndex]])");

        ////modlog(n"DEBUG", s"Spin Started");
        this.controller.gamemode().bankroll().Display();
        
        if !this.firstSpin { 
            this.addIcons(); 
        }
    
        this.controller.sound().Play("dev_vm_processing_leelou_beans");

        let timer = new animationTimer();
        timer.OnCreate(this.controller);

        timer.Call();
    }


    private cb func OnSpinFinished(proxy: ref<inkAnimProxy>) -> Bool {
        ////modlog(n"DEBUG", s"Spin Finished");
        this.idleFix();
        this.freeSpin(false);
        this.firstSpin = false;

        this.spun = false;
        this.spinButton.resetText();
        this.spinButton.ApplyDisabled();

        this.controller.gamemode().colorJackpot(-1);
        this.controller.gamemode().Play(this.lastPrizeIndex);
        this.addIcons();

        if this.auto && !this.controller.money().isBrokeboi() {
            this.spinWheel();
        }

        return true;
    }


}
