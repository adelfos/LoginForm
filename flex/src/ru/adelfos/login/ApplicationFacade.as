/**
 * Created by adelfos on 18.07.2016.
 */
package ru.adelfos.login {
import org.puremvc.as3.patterns.facade.Facade;

import ru.adelfos.login.controller.ApplicationStartupCommand;
import ru.adelfos.login.controller.LoginCommand;
import ru.adelfos.login.controller.RegistrationCommand;

public class ApplicationFacade  extends Facade{

    public static const APP_STARTUP: String = "appStartup";

    public static const LOGIN:String = "login";
    public static const LOGIN_OK:String = "loginOk";
    public static const LOGIN_NEED:String = "loginNeed";

    public static const REGISTRATION:String = "registration";
    public static const REGISTRATION_OK:String = "registrationOk";
    public static const REGISTRATION_NEED:String = "registrationNeed";

    public static const SERVER_ERROR:String = "serverError";

    public static function getInstance(): ApplicationFacade
    {
        if (instance == null)
            instance = new ApplicationFacade();
        return instance as ApplicationFacade;
    }

    override protected function initializeController() : void
    {
        super.initializeController();

        registerCommand( APP_STARTUP, ApplicationStartupCommand );
        registerCommand( LOGIN, LoginCommand );
        registerCommand( REGISTRATION, RegistrationCommand );
    }

    public function startup(app: Main):void
    {
        this.sendNotification( ApplicationFacade.APP_STARTUP, app );
    }
}
}
