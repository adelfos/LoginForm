/**
 * Created by adelfos on 20.07.2016.
 */
package ru.adelfos.login.controller {
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.command.SimpleCommand;

import ru.adelfos.login.model.UsersProxy;

import ru.adelfos.login.model.vo.UserVO;

public class RegistrationCommand extends SimpleCommand {
    override public function execute(note: INotification) :void
    {
        var userVO: UserVO = note.getBody() as UserVO;
        var usersProxy:UsersProxy = facade.retrieveProxy(UsersProxy.NAME) as UsersProxy;
        usersProxy.registration(userVO);
    }
}
}
