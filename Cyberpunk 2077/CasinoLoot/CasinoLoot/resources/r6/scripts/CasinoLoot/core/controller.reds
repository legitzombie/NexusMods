import Codeware.UI.*
import Audioware.*

public class controller {
    let root: ref<inkCompoundWidget>;
    let horizontalPanels: array<ref<inkHorizontalPanel>>;
    let verticalPanels: array<ref<inkVerticalPanel>>;
    let buttons: array<ref<spinButton>>;
    let player: ref<GameObject>;

    let money: ref<money>;
    let gamemode: ref<gamemode>;
    let wheel: ref<wheel>;
    let jackpot: ref<jackpot>;
    let sound: ref<sound>;

    let page: ref<BrowserController>;

    public func onCreate(root: ref<inkCompoundWidget>, player: ref<GameObject>, page: ref<BrowserController>) -> Void {
        this.root = root;
        this.Clear();

        this.money = new money();
        this.money.OnCreate(player, this);

        this.jackpot = new jackpot();
        this.jackpot.OnCreate(this);

        this.gamemode = new gamemode();
        this.gamemode.OnCreate(this, player);

        this.wheel = new wheel();
        this.wheel.OnCreate(this, this.gamemode);

        this.sound = new sound();
        this.sound.OnCreate(this);

        this.player = player;
        this.page = page;
    }

    public func addVerticalPanel(panel: ref<inkVerticalPanel>) -> Void {
        ArrayPush(this.verticalPanels, panel);
    }

    public func addHorizontalPanel(panel: ref<inkHorizontalPanel>) -> Void {
        ArrayPush(this.horizontalPanels, panel);
    }

    public func addSharedButton(btn: ref<spinButton>) -> Void {
        ArrayPush(this.buttons, btn);
    }

    public func money() -> ref<money> {
        return this.money;
    }

    public func gamemode() -> ref<gamemode> {
        return this.gamemode;
    }

    public func jackpot() -> ref<jackpot> {
        return this.jackpot;
    }

    public func wheel() -> ref<wheel> {
        return this.wheel;
    }

    public func sound() -> ref<sound> {
        return this.sound;
    }

    public func page() -> ref<BrowserController> {
        return this.page;
    }

    public func getSharedPanel(i: Int32, vertical: Bool) -> ref<inkCompoundWidget> {
        if (vertical) {
            return this.verticalPanels[i];
        }
        return this.horizontalPanels[i];
    }

    public func getSharedButton(i: Int32) -> ref<spinButton> {
        return this.buttons[i];
    }

    public func Clear() -> Void {
        this.root.RemoveAllChildren();
    }

    public func getRoot() -> ref<inkCompoundWidget> {
        return this.root;
    }

    public func getPlayer() -> ref<GameObject> {
        return this.player;
    }

}