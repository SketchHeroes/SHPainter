package mx.managers
{
   import flash.events.EventDispatcher;
   import mx.core.mx_internal;
   import mx.core.Singleton;
   import flash.display.DisplayObject;
   import mx.core.IToolTip;
   import mx.effects.IAbstractEffect;
   import mx.core.IUIComponent;

   use namespace mx_internal;

   public class ToolTipManager extends EventDispatcher
   {
      public function ToolTipManager() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var implClassDependency:ToolTipManagerImpl;

      private static var _impl:IToolTipManager2;

      private static function get impl() : IToolTipManager2 {
         if(!_impl)
         {
            _impl=IToolTipManager2(Singleton.getInstance("mx.managers::IToolTipManager2"));
         }
         return _impl;
      }

      public static function get currentTarget() : DisplayObject {
         return impl.currentTarget;
      }

      public static function set currentTarget(param1:DisplayObject) : void {
         impl.currentTarget=param1;
         return;
      }

      public static function get currentToolTip() : IToolTip {
         return impl.currentToolTip;
      }

      public static function set currentToolTip(param1:IToolTip) : void {
         impl.currentToolTip=param1;
         return;
      }

      public static function get enabled() : Boolean {
         return impl.enabled;
      }

      public static function set enabled(param1:Boolean) : void {
         impl.enabled=param1;
         return;
      }

      public static function get hideDelay() : Number {
         return impl.hideDelay;
      }

      public static function set hideDelay(param1:Number) : void {
         impl.hideDelay=param1;
         return;
      }

      public static function get hideEffect() : IAbstractEffect {
         return impl.hideEffect;
      }

      public static function set hideEffect(param1:IAbstractEffect) : void {
         impl.hideEffect=param1;
         return;
      }

      public static function get scrubDelay() : Number {
         return impl.scrubDelay;
      }

      public static function set scrubDelay(param1:Number) : void {
         impl.scrubDelay=param1;
         return;
      }

      public static function get showDelay() : Number {
         return impl.showDelay;
      }

      public static function set showDelay(param1:Number) : void {
         impl.showDelay=param1;
         return;
      }

      public static function get showEffect() : IAbstractEffect {
         return impl.showEffect;
      }

      public static function set showEffect(param1:IAbstractEffect) : void {
         impl.showEffect=param1;
         return;
      }

      public static function get toolTipClass() : Class {
         return impl.toolTipClass;
      }

      public static function set toolTipClass(param1:Class) : void {
         impl.toolTipClass=param1;
         return;
      }

      mx_internal  static function registerToolTip(param1:DisplayObject, param2:String, param3:String) : void {
         impl.registerToolTip(param1,param2,param3);
         return;
      }

      mx_internal  static function registerErrorString(param1:DisplayObject, param2:String, param3:String) : void {
         impl.registerErrorString(param1,param2,param3);
         return;
      }

      mx_internal  static function sizeTip(param1:IToolTip) : void {
         impl.sizeTip(param1);
         return;
      }

      public static function createToolTip(param1:String, param2:Number, param3:Number, param4:String=null, param5:IUIComponent=null) : IToolTip {
         return impl.createToolTip(param1,param2,param3,param4,param5);
      }

      public static function destroyToolTip(param1:IToolTip) : void {
         return impl.destroyToolTip(param1);
      }
   }

}