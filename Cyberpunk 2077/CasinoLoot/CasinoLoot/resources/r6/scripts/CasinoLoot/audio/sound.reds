public class sound {
    let lastPlayed: String;
    let controller: ref<controller>;

    public func OnCreate(controller: ref<controller>) -> Void {
        this.controller = controller;
    }

    public func Play(sound: String) -> Void {
        this.lastPlayed = sound;
        GameInstance.GetAudioSystem(this.controller.getPlayer().GetGame()).Play(StringToName(sound), this.controller.getPlayer().GetEntityID(), StringToName("Default"));
    }

    public func last() -> String {
        return this.lastPlayed;
    }

    public func reset() -> Void {
        this.lastPlayed = "";
    }
}