package mx.states
{
   import mx.core.mx_internal;
   import mx.effects.IEffect;

   use namespace mx_internal;

   public class Transition extends Object
   {
      public function Transition() {
         this.interruptionBehavior=InterruptionBehavior.END;
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var effect:IEffect;

      public var fromState:String = "*";

      public var toState:String = "*";

      public var autoReverse:Boolean = false;

      public var interruptionBehavior:String;
   }

}