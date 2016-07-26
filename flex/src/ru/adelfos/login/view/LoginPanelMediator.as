/**
 * Created by adelfos on 18.07.2016.
 */
package ru.adelfos.login.view {
import flash.events.Event;

import mx.controls.Alert;

import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.patterns.mediator.Mediator;

import ru.adelfos.login.ApplicationFacade;
import ru.adelfos.login.model.vo.UserVO;

import ru.adelfos.login.view.components.LoginPanel;

public class LoginPanelMediator extends Mediator implements IMediator {

    public static const NAME:String = 'loginPanelMediator';

    public function LoginPanelMediator(viewComponent:Object = null) {
        super(mediatorName, viewComponent);
    }


    override public function onRegister():void {
        super.onRegister();

        loginPanel.addEventListener( LoginPanel.TRY_LOGIN, loginHandler );
        loginPanel.addEventListener( LoginPanel.NEED_REGISTRATION, needRegistrationHandler);
    }


    override public function onRemove():void {
        super.onRemove();

        loginPanel.removeEventListener( LoginPanel.TRY_LOGIN, loginHandler );
        loginPanel.removeEventListener( LoginPanel.NEED_REGISTRATION, needRegistrationHandler);
    }

    private function loginHandler(event:Event=null):void {
        var userVO: UserVO = new UserVO();
        userVO.login = loginPanel.login.text;
        userVO.pass = loginPanel.password.text;

        sendNotification( ApplicationFacade.LOGIN, userVO );
    }

    protected function get loginPanel(): LoginPanel
    {
        return viewComponent as LoginPanel;
    }

    private function needRegistrationHandler(event:Event):void {
        sendNotification( ApplicationFacade.REGISTRATION_NEED );
    }
}
}
