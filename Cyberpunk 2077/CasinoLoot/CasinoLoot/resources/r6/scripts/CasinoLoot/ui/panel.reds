public class panelBuilder {

    let anchors: array<inkEAnchor>;

    public func OnCreate() -> Void {
        this.anchors = [inkEAnchor.LeftFillVerticaly, inkEAnchor.RightFillVerticaly, inkEAnchor.TopCenter, inkEAnchor.Centered, inkEAnchor.BottomCenter];
    }

    public func verticalPanel(
        controller: ref<controller>,
        size: array<Float>,
        margin: array<Float>,
        anchor: array<Float>,
        anchorAlign: Int32,
        fit: Bool,
        interactive: Bool
    ) -> ref<inkVerticalPanel> {
        let name = "verticalPanel_" + RandRange(0, 10000000);
        //ModLog(n"DEBUG", name);
        let panel = new inkVerticalPanel();
        panel.SetName(StringToName(name));
        panel.SetSize(new Vector2(size[0], size[1]));
        panel.SetMargin(new inkMargin(margin[0], margin[1], margin[2], margin[3]));
        panel.SetAnchorPoint(new Vector2(anchor[0], anchor[1]));
        panel.SetAnchor(this.anchors[anchorAlign]);
        panel.SetFitToContent(fit);
        panel.SetVAlign(inkEVerticalAlign.Center);
        panel.SetHAlign(inkEHorizontalAlign.Center);
        panel.SetInteractive(interactive);
        panel.Reparent(controller.getRoot());
        controller.addVerticalPanel(panel);
        return panel;
    }

    public func horizontalPanel(
        controller: ref<controller>,
        size: array<Float>,
        margin: array<Float>,
        anchor: array<Float>,
        anchorAlign: Int32,
        fit: Bool,
        interactive: Bool
    ) -> ref<inkHorizontalPanel> {
        let name = "horizontalPanel_" + RandRange(0, 10000000);
        //ModLog(n"DEBUG", name);
        let panel = new inkHorizontalPanel();
        panel.SetName(StringToName(name));
        panel.SetSize(new Vector2(size[0], size[1]));
        panel.SetMargin(new inkMargin(margin[0], margin[1], margin[2], margin[3]));
        panel.SetAnchorPoint(new Vector2(anchor[0], anchor[1]));
        panel.SetAnchor(this.anchors[anchorAlign]);
        panel.SetFitToContent(fit);
        panel.SetVAlign(inkEVerticalAlign.Center);
        panel.SetHAlign(inkEHorizontalAlign.Center);
        panel.SetInteractive(interactive);
        panel.Reparent(controller.getRoot());
        controller.addHorizontalPanel(panel);
        return panel;
    }

}