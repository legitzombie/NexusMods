public class animationTimer extends DelayCallback {

    private let count: Int32;

    let controller: ref<controller>;

    public func OnCreate(controller: ref<controller>) -> Void {
        this.controller = controller;
        this.count = 0;
    }

    public func Call() -> Void {
        ////modlog(n"DEBUG", s"timer start");
        this.controller.getSharedButton(0).resetText();
        this.controller.getSharedButton(0).SetText(s"                   \(4 - this.count)...");

        if this.count < 4 {
            GameInstance.GetDelaySystem(this.controller.getPlayer().GetGame()).DelayCallback(this, 1.0);
        }else {
            if this.controller.wheel().isFree() {
                this.controller.getSharedButton(0).resetText();
            }else {
                this.controller.getSharedButton(0).SetText(s"         SPIN ($5,000)");
                this.controller.getSharedButton(0).setBackgroundColor(colors.yellowGlow());
            }
            
            this.controller.wheel().setIconColor(colors.yellowGlow());
            //this.controller.wheel().addIcons();
        }

        this.count += 1;
    }

}


