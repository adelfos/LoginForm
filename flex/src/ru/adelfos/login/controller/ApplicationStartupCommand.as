/**
 * Created by adelfos on 18.07.2016.
 */
package ru.adelfos.login.controller {
import org.puremvc.as3.patterns.command.MacroCommand;

public class ApplicationStartupCommand extends MacroCommand {

    override protected function initializeMacroCommand() :void
    {
        addSubCommand( ModelPrepCommand );
        addSubCommand( ViewPrepCommand );
    }
}
}
