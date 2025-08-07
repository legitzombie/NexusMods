import Codeware.UI.*

public class checkbox extends CustomButton {
    let controller: ref<controller>;

    let panel: ref<inkCompoundWidget>;
    let canvas: ref<inkCanvas>;
    let canvasImage: ref<inkImage>;

    	protected func CreateWidgets() -> Void {

		this.createCanvas();
        this.attachImage(n"off");

		this.SetRootWidget(this.canvas);
	}

    public func createCanvas() -> Void {
        this.canvas = new inkCanvas();
        this.canvas.SetName(n"CasinoLoot_checkbox");
        this.canvas.SetSize(new Vector2(64.0, 64.0));
        this.canvas.SetAnchor(inkEAnchor.Centered);
        this.canvas.SetHAlign(inkEHorizontalAlign.Center);
        this.canvas.SetVAlign(inkEVerticalAlign.Center);
        this.canvas.SetMargin(new inkMargin(0.0, -93.0, 0.0, 0.0));
        this.canvas.SetInteractive(false);
        this.canvas.Reparent(this.panel);
    }

    public func attachImage(src: CName) -> Void {
        this.canvasImage = new inkImage();
        this.canvasImage.SetName(n"CasinoLoot_checkbox_image");
        this.canvasImage.SetSize(new Vector2(64.0, 64.0));
        this.canvasImage.SetAnchor(inkEAnchor.RightFillVerticaly);
        this.canvasImage.SetAnchorPoint(new Vector2(0.0, 0.0));
        this.canvasImage.SetHAlign(inkEHorizontalAlign.Center);
        this.canvasImage.SetVAlign(inkEVerticalAlign.Center);
        this.canvasImage.SetInteractive(true);
        this.canvasImage.SetAtlasResource(r"base\\gameplay\\gui\\widgets\\casinoloot_checkbox.inkatlas");
        this.canvasImage.SetTexturePart(src);
        this.canvasImage.SetMargin(new inkMargin(0.0, 0.0, 625.0, 0.0));
        this.canvas.RemoveAllChildren();
        this.canvasImage.Reparent(this.canvas);
    }

    public static func Create(controller: ref<controller>, panel: ref<inkCompoundWidget>) -> ref<checkbox> {
		let self: ref<checkbox> = new checkbox();
        self.panel = panel;
		self.controller = controller;

        self.Reparent(self.panel);

		self.CreateInstance();
		return self;
	}
}