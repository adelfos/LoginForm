/**
 * Created by adelfos on 20.07.2016.
 */
package ru.adelfos.login.view {
import mx.events.FlexEvent;

import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

import ru.adelfos.login.ApplicationFacade;
import ru.adelfos.login.model.vo.UserVO;

import ru.adelfos.login.view.components.ProfilePanel;

public class ProfilePanelMediator extends Mediator implements IMediator {

    public static const NAME:String = 'profilePanelMediator';

    private var userVO : UserVO;
    public function ProfilePanelMediator(viewComponent:Object = null) {
        super(mediatorName, viewComponent);
    }

    override public function listNotificationInterests():Array
    {
        return [
            ApplicationFacade.LOGIN_OK,
            ApplicationFacade.REGISTRATION_OK,
        ];
    }


    override public function onRegister():void {
        super.onRegister();

        registrationPanel.addEventListener(FlexEvent.SHOW, creationCompleteHandler);
    }

    override public function onRemove():void {
        super.onRemove();

        registrationPanel.removeEventListener(FlexEvent.SHOW, creationCompleteHandler);
    }

        override public function handleNotification( note:INotification ):void
    {
        switch (note.getName())
        {
            case ApplicationFacade.LOGIN_OK:
            case ApplicationFacade.REGISTRATION_OK:
                     userVO = note.getBody() as UserVO;
                break;
            default:
        }
    }

    private function get registrationPanel ():ProfilePanel
    {
        return viewComponent as ProfilePanel;
    }

    private function creationCompleteHandler(event:FlexEvent):void {
        registrationPanel.email.text =      userVO.email;
        registrationPanel.login.text =      userVO.login;
        registrationPanel.name1.text =      userVO.name;
        registrationPanel.surname.text =      userVO.surname;
        trace("mail: " + userVO.email +"!");
    }
}
}
