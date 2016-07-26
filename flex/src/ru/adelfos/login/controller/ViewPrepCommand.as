/**
 * Created by adelfos on 18.07.2016.
 */
package ru.adelfos.login.controller {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

import ru.adelfos.login.view.ApplicationMediator;

public class ViewPrepCommand extends SimpleCommand {
    override public function execute(note: INotification) :void
    {
        var mainApp : Main = note.getBody() as Main;
        var applicationMediator : ApplicationMediator = new ApplicationMediator( mainApp );
        facade.registerMediator( applicationMediator );
    }
}
}
