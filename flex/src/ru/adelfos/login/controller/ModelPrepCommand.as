/**
 * Created by adelfos on 18.07.2016.
 */
package ru.adelfos.login.controller {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

import ru.adelfos.login.model.UsersProxy;

public class ModelPrepCommand extends SimpleCommand{

        override public function execute( note:INotification ) :void
        {
            facade.registerProxy( new UsersProxy() );
        }
}
}
