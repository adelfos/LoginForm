/**
 * Created by adelfos on 18.07.2016.
 */
package ru.adelfos.login.view {
import mx.controls.Alert;

import org.puremvc.as3.interfaces.IMediator;
import org.puremvc.as3.interfaces.INotification;
import org.puremvc.as3.patterns.mediator.Mediator;

import ru.adelfos.login.ApplicationFacade;

public class ApplicationMediator extends Mediator implements IMediator {

    public static const NAME:String = 'ApplicationMediator';

    public function ApplicationMediator( viewComponent:Object = null) {
        super(NAME, viewComponent);

        facade.registerMediator(new LoginPanelMediator(app.loginPanel));
        facade.registerMediator(new ProfilePanelMediator(app.profilePanel));
        facade.registerMediator(new RegistrationPanelMediator(app.registrationPanel));
    }
    override public function listNotificationInterests():Array
    {
        return [
            ApplicationFacade.LOGIN_OK,
            ApplicationFacade.REGISTRATION_OK,
            ApplicationFacade.SERVER_ERROR,
            ApplicationFacade.REGISTRATION_NEED,
            ApplicationFacade.LOGIN_NEED,
        ];
    }


    override public function handleNotification( note:INotification ):void
    {
        switch (note.getName())
        {
            case ApplicationFacade.LOGIN_OK:
                app.viewStack.selectedChild = app.profilePanel;
                break;
            case ApplicationFacade.REGISTRATION_OK:
                app.viewStack.selectedChild = app.profilePanel;
                break;
            case ApplicationFacade.SERVER_ERROR:
                    var body: Object = note.getBody();
                    Alert.show("Err serv:" + body!= null? body.toString() :"" );
                break;
            case ApplicationFacade.REGISTRATION_NEED:
                app.viewStack.selectedChild = app.registrationPanel;
                break;
            case ApplicationFacade.LOGIN_NEED:
                app.viewStack.selectedChild = app.loginPanel;
                break;

            default:
        }
    }
    protected function get app(): Main
    {
        return viewComponent as Main;
    }
}
}
