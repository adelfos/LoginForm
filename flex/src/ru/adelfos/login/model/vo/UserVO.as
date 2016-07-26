/**
 * Created by adelfos on 18.07.2016.
 */
package ru.adelfos.login.model.vo {
import com.adobe.crypto.MD5;

[Bindable]
public class UserVO {
    public var login: String = "";
    private var _pass: String = "";
    public var email: String = "";
    public var name: String = "";
    public var surname: String = "";


    public function get pass():String {
        return _pass;
    }

    public function set pass(value:String):void {
        var solt: String = "solt";
        _pass = MD5.hash(value + solt);
    }
}
}
