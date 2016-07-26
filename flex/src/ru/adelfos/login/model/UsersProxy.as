/**
 * Created by adelfos on 19.07.2016.
 */
package ru.adelfos.login.model {
import com.adobe.serialization.json.JSON;
import com.adobe.serialization.json.JSONParseError;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.puremvc.as3.interfaces.IProxy;
import org.puremvc.as3.patterns.proxy.Proxy;

import ru.adelfos.login.ApplicationFacade;
import ru.adelfos.login.model.vo.UserVO;

public class UsersProxy extends Proxy implements IProxy {
    public static const NAME:String = 'usersProxy';


    public function UsersProxy() {
        super (NAME, new Object());
    }

    public function login(userVO:UserVO):void
    {
        sendRequest("/api/authentication/", userVO, ApplicationFacade.LOGIN_OK);
    }

    public function registration(userVO:UserVO):void
    {
        sendRequest("/api/users", userVO, ApplicationFacade.REGISTRATION_OK);
    }

    private function sendRequest(url:String, data:Object, notificationName:String):void
    {

        var request: URLRequest = new URLRequest("http://i.adelfos.ru" + url);
        request.method = "POST";
        request.contentType = "application/json";
        request.data = com.adobe.serialization.json.JSON.encode(data);//stringify(data);

        var loader : URLLoader = new URLLoader(request);
        loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);

        loader.addEventListener(Event.COMPLETE, function(ev:Event):void
        {
            completeHandler(loader.data, notificationName);
        });
    }

    private function  completeHandler(data:Object, notificationName:String ):void
    {
        var json:String = data as String;
        try{
            var obj : Object =  com.adobe.serialization.json.JSON.decode(json);
        }catch (e:JSONParseError )
        {

        }

        if(obj != null && obj.hasOwnProperty("status") )
        {
            if( obj["status"] == "OK")
            {
                var userVO:UserVO =  ObjectToUserVO(obj["data"]);
                sendNotification(notificationName, userVO);
            }else {
                var mess:* = obj["message"];
                sendNotification( ApplicationFacade.SERVER_ERROR, mess );
            }
        }else {
            sendNotification( ApplicationFacade.SERVER_ERROR, json );
        }
    }

    private function errorHandler(e:* ):void {
        sendNotification( ApplicationFacade.SERVER_ERROR, e.toString() );
    }


    private function ObjectToUserVO(obj:Object): UserVO
    {
        var userVO : UserVO = new UserVO();
        for(var a:String in obj)
        {
            if(userVO.hasOwnProperty(a))
                userVO[a] = obj[a];
        }
        return userVO;
    }
}
}
