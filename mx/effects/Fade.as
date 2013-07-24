package mx.effects
{
   import mx.core.mx_internal;
   import mx.effects.effectClasses.FadeInstance;

   use namespace mx_internal;

   public class Fade extends TweenEffect
   {
      public function Fade(param1:Object=null) {
         super(param1);
         instanceClass=FadeInstance;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var AFFECTED_PROPERTIES:Array = ["alpha","visible"];

      public var alphaFrom:Number;

      public var alphaTo:Number;

      override public function getAffectedProperties() : Array {
         return AFFECTED_PROPERTIES;
      }

      override protected function initInstance(param1:IEffectInstance) : void {
         super.initInstance(param1);
         var _loc2_:FadeInstance = FadeInstance(param1);
         _loc2_.alphaFrom=this.alphaFrom;
         _loc2_.alphaTo=this.alphaTo;
         return;
      }
   }

}