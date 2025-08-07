import Codeware.UI.*

public class spinButton extends CustomButton {

	let controller: ref<controller>;
  
	protected let m_icon: wref<inkImage>;
  	protected let m_leftSideBg: wref<inkImage>;
  	protected let m_leftSideFg: wref<inkImage>;
	protected let m_hover: wref<inkFlex>;
	protected let m_player: wref<GameObject>;
	protected let m_disabledRootAnimDef: ref<inkAnimDef>;
	protected let m_disabledRootAnimProxy: ref<inkAnimProxy>;
	protected let m_hoverFillAnimDef: ref<inkAnimDef>;
	protected let m_hoverFillAnimProxy: ref<inkAnimProxy>;
	protected let m_background: ref<inkImage>;
	let m_isDisabled: Bool;

	protected func CreateWidgets() -> Void {

		this.m_isDisabled = false;

		let root: ref<inkCanvas> = new inkCanvas();
		root.SetName(n"button");
		root.SetSize(new Vector2(500.0, 120.0)); 
		root.SetMargin(new inkMargin(0.0, 40.0, 0.0, 0.0));
		root.SetInteractive(true);

		let flexContainer: ref<inkFlex> = new inkFlex();
		flexContainer.SetName(n"flexContainer");
        flexContainer.SetAnchor(inkEAnchor.TopFillHorizontaly);
		flexContainer.SetMargin(new inkMargin(15.0, 0.0, 0.0, 0.0));
		flexContainer.Reparent(root);
		
		let background: ref<inkImage> = new inkImage();
		background.SetName(n"background");
		background.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		background.SetTexturePart(n"button_big2_bg");
		background.SetNineSliceScale(true);
		background.SetAnchorPoint(new Vector2(0.5, 0.5));
		background.SetOpacity(1.0);
		background.SetTintColor(colors.yellowGlow());
		background.SetSize(new Vector2(532.0, 345.0));
		background.Reparent(flexContainer);
		
		let frame: ref<inkImage> = new inkImage();
		frame.SetName(n"frame");
		frame.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		frame.SetTexturePart(n"button_big2_fg");
		frame.SetNineSliceScale(true);
		frame.SetAnchorPoint(new Vector2(0.5, 0.5));
		frame.SetTintColor(colors.black());
		frame.SetSize(new Vector2(532.0, 345.0));
		frame.Reparent(flexContainer);
		
		let backgroundLeftBg: ref<inkImage> = new inkImage();
		backgroundLeftBg.SetName(n"background_leftBg");
		backgroundLeftBg.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		backgroundLeftBg.SetTexturePart(n"item_side_bg");
		backgroundLeftBg.SetNineSliceScale(true);
		backgroundLeftBg.SetMargin(new inkMargin(-15.0, 0.0, 0.0, 0.0));
		backgroundLeftBg.SetHAlign(inkEHorizontalAlign.Left);
		backgroundLeftBg.SetAnchorPoint(new Vector2(0.5, 0.5));
		backgroundLeftBg.SetOpacity(1.0);
		backgroundLeftBg.SetTintColor(colors.black());
		backgroundLeftBg.SetSize(new Vector2(16.0, 345.0));
		backgroundLeftBg.Reparent(flexContainer);
		
		let backgroundLeftFrame: ref<inkImage> = new inkImage();
		backgroundLeftFrame.SetName(n"background_leftFrame");
		backgroundLeftFrame.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		backgroundLeftFrame.SetTexturePart(n"item_side_fg");
		backgroundLeftFrame.SetNineSliceScale(true);
		backgroundLeftFrame.SetMargin(new inkMargin(-15.0, 0.0, 0.0, 0.0));
		backgroundLeftFrame.SetHAlign(inkEHorizontalAlign.Left);
		backgroundLeftFrame.SetAnchorPoint(new Vector2(0.5, 0.5));
		backgroundLeftFrame.SetTintColor(colors.black());
		backgroundLeftFrame.SetSize(new Vector2(16.0, 345.0));
		backgroundLeftFrame.Reparent(flexContainer);
		
		let container: ref<inkHorizontalPanel> = new inkHorizontalPanel();
		container.SetName(n"container");
		container.SetFitToContent(true);
		container.SetMargin(new inkMargin(0.0, 5.0, 0.0, 0.0));
		container.SetHAlign(inkEHorizontalAlign.Left);
		container.SetVAlign(inkEVerticalAlign.Top);
		container.Reparent(flexContainer);
		
		let inkVerticalPanelWidget8: ref<inkVerticalPanel> = new inkVerticalPanel();
		inkVerticalPanelWidget8.SetName(n"inkVerticalPanelWidget8");
		inkVerticalPanelWidget8.SetFitToContent(true);
		inkVerticalPanelWidget8.SetMargin(new inkMargin(20.0, 0.0, -10.0, 0.0));
		inkVerticalPanelWidget8.Reparent(container);
		
		let icon: ref<inkImage> = new inkImage();
		icon.SetName(n"icon");
		icon.SetAtlasResource(r"base\\gameplay\\gui\\fullscreen\\hub_menu\\hub_atlas.inkatlas");
		icon.SetHAlign(inkEHorizontalAlign.Center);
		icon.SetVAlign(inkEVerticalAlign.Center);
		icon.SetAnchorPoint(new Vector2(0.5, 0.5));
		icon.SetSizeRule(inkESizeRule.Stretch);
		icon.SetSize(new Vector2(80.0, 80.0));
		icon.SetScale(new Vector2(0.8, 0.8));
		icon.Reparent(inkVerticalPanelWidget8);
		
		let label: ref<inkText> = new inkText();
		label.SetName(n"label");
		label.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
		label.SetFontStyle(n"Bold");
		label.SetFontSize(89);
		label.SetLetterCase(textLetterCase.UpperCase);
		label.SetVerticalAlignment(textVerticalAlignment.Center);
		label.SetContentHAlign(inkEHorizontalAlign.Center);
		label.SetContentVAlign(inkEVerticalAlign.Center);
		label.SetText("         SPIN ($5,000)");
		label.SetMargin(new inkMargin(0.0, 0.0, 0.0, 0.0));
		label.SetHAlign(inkEHorizontalAlign.Left);
		label.SetVAlign(inkEVerticalAlign.Center);
        label.SetTintColor(colors.black());
		label.SetSize(new Vector2(360.0, 120.0));
		label.Reparent(container);

		let hoverFrames: ref<inkFlex> = new inkFlex();
		hoverFrames.SetName(n"hoverFrames");
		hoverFrames.SetOpacity(0.0);
		hoverFrames.SetSize(new Vector2(100.0, 100.0));
		hoverFrames.Reparent(flexContainer);
		
		let frameHovered: ref<inkImage> = new inkImage();
		frameHovered.SetName(n"frameHovered");
		frameHovered.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		frameHovered.SetTexturePart(n"button_big2_fg");
		frameHovered.SetNineSliceScale(true);
		frameHovered.SetAnchorPoint(new Vector2(0.5, 0.5));
		frameHovered.SetTintColor(colors.black());
		frameHovered.SetSize(new Vector2(532.0, 345.0));
		frameHovered.Reparent(hoverFrames);
		
		let frameHoveredBg: ref<inkImage> = new inkImage();
		frameHoveredBg.SetName(n"frameHoveredBg");
		frameHoveredBg.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		frameHoveredBg.SetTexturePart(n"button_big2_bg");
		frameHoveredBg.SetNineSliceScale(true);
		frameHoveredBg.SetAnchorPoint(new Vector2(0.5, 0.5));
		frameHoveredBg.SetOpacity(0.05);
		frameHoveredBg.SetTintColor(colors.black());
		frameHoveredBg.SetSize(new Vector2(532.0, 345.0));
		frameHoveredBg.Reparent(hoverFrames);
		
		let backgroundLeftHover: ref<inkImage> = new inkImage();
		backgroundLeftHover.SetName(n"background_leftHover");
		backgroundLeftHover.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		backgroundLeftHover.SetTexturePart(n"item_side_fg");
		backgroundLeftHover.SetNineSliceScale(true);
		backgroundLeftHover.SetMargin(new inkMargin(-15.0, 0.0, 0.0, 0.0));
		backgroundLeftHover.SetHAlign(inkEHorizontalAlign.Left);
		backgroundLeftHover.SetAnchorPoint(new Vector2(0.5, 0.5));
		backgroundLeftHover.SetTintColor(colors.black());
		backgroundLeftHover.SetSize(new Vector2(16.0, 345.0));
		backgroundLeftHover.Reparent(hoverFrames);
		
		let backgroundLeftBg: ref<inkImage> = new inkImage();
		backgroundLeftBg.SetName(n"background_leftBg");
		backgroundLeftBg.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		backgroundLeftBg.SetTexturePart(n"item_side_bg");
		backgroundLeftBg.SetNineSliceScale(true);
		backgroundLeftBg.SetMargin(new inkMargin(-15.0, 0.0, 0.0, 0.0));
		backgroundLeftBg.SetHAlign(inkEHorizontalAlign.Left);
		backgroundLeftBg.SetAnchorPoint(new Vector2(0.5, 0.5));
		backgroundLeftBg.SetOpacity(1.0); 
		backgroundLeftBg.SetTintColor(colors.black());
		backgroundLeftBg.SetSize(new Vector2(16.0, 345.0));
		backgroundLeftBg.Reparent(hoverFrames);


		this.m_root = root;
		this.m_background = background;
		this.m_label = label;
		this.m_icon = icon;
		this.m_hover = hoverFrames;
    	this.m_leftSideBg = backgroundLeftBg;
    	this.m_leftSideFg = backgroundLeftFrame;
		this.resetText();
		this.SetRootWidget(root);
	}

	protected func CreateAnimations() -> Void {
		let disabledRootAlphaAnim: ref<inkAnimTransparency> = new inkAnimTransparency();
		disabledRootAlphaAnim.SetStartTransparency(1.0);
		disabledRootAlphaAnim.SetEndTransparency(0.3);
		disabledRootAlphaAnim.SetDuration(this.m_useAnimations ? 0.05 : 0.0001);

		this.m_disabledRootAnimDef = new inkAnimDef();
		this.m_disabledRootAnimDef.AddInterpolator(disabledRootAlphaAnim);

		let hoverFillAlphaAnim: ref<inkAnimTransparency> = new inkAnimTransparency();
		hoverFillAlphaAnim.SetStartTransparency(0.0);
		hoverFillAlphaAnim.SetEndTransparency(1.0);
		hoverFillAlphaAnim.SetDuration(this.m_useAnimations ? 0.2 : 0.0001);

		this.m_hoverFillAnimDef = new inkAnimDef();
		this.m_hoverFillAnimDef.AddInterpolator(hoverFillAlphaAnim);
	}

	public func disabled() -> Bool {
		return this.m_isDisabled;
	}

	public func ApplyDisabled() -> Void {
		this.m_isDisabled = !this.m_isDisabled;
		//ModLog(n"DEBUG", s"Disabled: \(this.m_isDisabled)");
		let color: HDRColor;

		if this.m_isDisabled {
			color = colors.green();
		} else {
			color = colors.yellowGlow();
		};
		this.setBackgroundColor(color);
	}

	public func resetText() -> Void {
		if this.controller.wheel().isFree() {
			this.SetText("            FREE SPIN");
			this.setBackgroundColor(colors.greenGlow());
		}else if !this.controller.money().isBrokeboi() && !this.m_isDisabled {
			this.SetText("         SPIN ($5,000)");
			this.setBackgroundColor(colors.yellowGlow());
			//this.m_isDisabled = false;
		}else if this.controller.money().isBrokeboi() {
			this.setBackgroundColor(colors.redGlow());
			this.SetText("      $5,000 REQUIRED");
			this.m_isDisabled = true;
		}else if this.m_isDisabled {
			this.setBackgroundColor(colors.green());
		}else {
			this.setBackgroundColor(colors.yellowGlow());
		}
	}

	public func setBackgroundColor(color: HDRColor) -> Void {
		this.m_background.SetTintColor(color);
	}

	protected func ApplyHoveredState() -> Void {
		let reverseAnimOpts: inkAnimOptions;
		reverseAnimOpts.playReversed = !this.m_isHovered || this.m_isDisabled;

		this.m_hoverFillAnimProxy.Stop();
		this.m_hoverFillAnimProxy = this.m_hover.PlayAnimationWithOptions(this.m_hoverFillAnimDef, reverseAnimOpts);
	}

	public func SetIcon(icon: CName) -> Void {
		this.m_icon.SetTexturePart(icon);

		if NotEquals(icon, n"") {
			this.m_icon.SetVisible(true);
		} else {
			this.m_icon.SetVisible(false);
		}
	}

	public func SetIcon(icon: CName, atlas: ResRef) -> Void {
		this.m_icon.SetAtlasResource(atlas);
		this.SetIcon(icon);
	}

	protected cb func OnHoverOver(evt: ref<inkPointerEvent>) -> Bool {
		if !this.m_isDisabled && !this.controller.wheel().isFree() && !this.controller.money().isBrokeboi() {
			let color = colors.green();
        	this.m_background.SetTintColor(color);
		}
    }

    protected cb func OnHoverOut(evt: ref<inkPointerEvent>) -> Bool {
		if !this.m_isDisabled && !this.controller.wheel().isFree() && !this.controller.money().isBrokeboi() {
			let color = colors.yellowGlow();
        	this.m_background.SetTintColor(color);
		}
    }

	public static func Create(player: wref<GameObject>, controller: ref<controller>) -> ref<spinButton> {
		let self: ref<spinButton> = new spinButton();
		self.m_player = player;
		self.controller = controller;
		self.CreateInstance();
		return self;
	}
}
