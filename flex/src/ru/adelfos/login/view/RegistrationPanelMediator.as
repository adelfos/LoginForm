/**
 * Created by adelfos on 20.07.2016.
 */
package ru.adelfos.login.view {
import flash.events.Event;

import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.patterns.mediator.Mediator;

import ru.adelfos.login.ApplicationFacade;

import ru.adelfos.login.model.vo.UserVO;

import ru.adelfos.login.view.components.RegistrationPanel;

public class RegistrationPanelMediator extends Mediator implements IMediator {

    public static const NAME:String = 'registrationPanelMediator';

    public function RegistrationPanelMediator(viewComponent:Object = null) {
        super(NAME, viewComponent);
    }

    override public function onRegister():void {
        super.onRegister();

        registrationPanel.addEventListener( RegistrationPanel.TRY_REGISTRATION, registration );
        registrationPanel.addEventListener( RegistrationPanel.NEED_LOGIN, needLoginHandler);
    }

    override public function onRemove():void {
        super.onRemove();

        registrationPanel.removeEventListener( RegistrationPanel.TRY_REGISTRATION, registration );
        registrationPanel.removeEventListener( RegistrationPanel.NEED_LOGIN, needLoginHandler);
    }

    private function registration(event:Event=null):void {
        var userVO: UserVO = new UserVO();
        userVO.login = registrationPanel.login.text;
        userVO.pass = registrationPanel.password.text;
        userVO.email = registrationPanel.email.text;
        userVO.name = registrationPanel.name1.text;
        userVO.surname = registrationPanel.surname.text;

        sendNotification( ApplicationFacade.REGISTRATION, userVO );
    }

    private function get registrationPanel ():RegistrationPanel
    {
       return viewComponent as RegistrationPanel;
    }

    private function needLoginHandler(event:Event):void {
        sendNotification( ApplicationFacade.LOGIN_NEED );
    }
}
}
