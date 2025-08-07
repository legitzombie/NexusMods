public class bankroll {

    let ImagesData: array<ImageData>;
    let Canvas: ref<inkCanvas>;
    let CanvasImage: ref<inkImage>;
    let panel: ref<inkCompoundWidget>;
    let player: wref<GameObject>;
    let controller: ref<controller>;


    public func OnCreate(
        panel: ref<inkCompoundWidget>,
        player: wref<GameObject>,
        controller: ref<controller>
    ) -> Void {
        this.controller = controller;
        this.panel = panel;
        this.player = player;

        this.Canvas = new inkCanvas();
        this.Canvas.SetName(n"bankroll");
        this.Canvas.SetFitToContent(true);
        this.Canvas.SetHAlign(inkEHorizontalAlign.Center);
        this.Canvas.SetVAlign(inkEVerticalAlign.Bottom);
        this.Canvas.SetInteractive(false);
        this.Canvas.Reparent(this.panel);

        // Create the background image
        this.CanvasImage = new inkImage();
        this.CanvasImage.SetName(n"bankrollImage");
        this.CanvasImage.SetFitToContent(true);
        this.CanvasImage.SetHAlign(inkEHorizontalAlign.Center);
        this.CanvasImage.SetVAlign(inkEVerticalAlign.Center);
        this.CanvasImage.SetAnchor(inkEAnchor.Centered);
        this.CanvasImage.SetAnchorPoint(0.2, 0.7);
        this.CanvasImage.SetScale(new Vector2(2.0, 2.0));
        this.CanvasImage.SetMargin(-500.0, -275.0, 0.0, 0.0);
        this.CanvasImage.SetInteractive(false);
        this.CanvasImage.SetAtlasResource(r"base\\gameplay\\gui\\widgets\\gachaloot_bankroll.inkatlas");
        this.CanvasImage.Reparent(this.Canvas);

        let brokie: ImageData;
        brokie.resource = "base\\gameplay\\gui\\widgets\\gachaloot_bankroll.inkatlas";
        brokie.part = "bankrollBrokie";

        let mid: ImageData;
        mid.resource = "base\\gameplay\\gui\\widgets\\gachaloot_bankroll.inkatlas";
        mid.part = "bankrollMid";

        let rich: ImageData;
        rich.resource = "base\\gameplay\\gui\\widgets\\gachaloot_bankroll.inkatlas";
        rich.part = "bankrollHigh";

        
        ArrayPush(this.ImagesData, brokie);
        ArrayPush(this.ImagesData, mid);
        ArrayPush(this.ImagesData, rich);

    };

public func Display() -> Void {
    let currentMoney = this.controller.money().Get();
    ////modlog(n"DEBUG", s"money: \(currentMoney)");
    let cost = 5000;

    if currentMoney >= cost && currentMoney < (cost*5) {
        this.setImage(this.ImagesData[0].part);
        this.setMargin([-600.0, -150.0, 0.0, 0.0]);
    } else if currentMoney >= (cost*5) && currentMoney < (cost*25) {
        this.setImage(this.ImagesData[1].part);
        this.setMargin([-600.0, -150.0, 0.0, 0.0]);
    } else if currentMoney >= (cost*25) {
        this.setImage(this.ImagesData[2].part);
        this.setMargin([-600.0, -275.0, 0.0, 0.0]);
    }else {
        this.Reset();
    }

};

public func Reset() -> Void {
    this.CanvasImage.SetTexturePart(n"");
}

public func setImage(part: String) -> Void {
    this.CanvasImage.SetTexturePart(StringToName(part));
}

public func setMargin(margin: array<Float>) -> Void {
    this.CanvasImage.SetMargin(margin[0], margin[1], margin[2], margin[3]);
}

}