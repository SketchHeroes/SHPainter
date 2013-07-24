package mx.containers.utilityClasses
{
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.core.Container;
   import mx.resources.ResourceManager;

   use namespace mx_internal;

   public class Layout extends Object
   {
      public function Layout() {
         this.resourceManager=ResourceManager.getInstance();
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      protected var resourceManager:IResourceManager;

      private var _target:Container;

      public function get target() : Container {
         return this._target;
      }

      public function set target(param1:Container) : void {
         this._target=param1;
         return;
      }

      public function measure() : void {
         return;
      }

      public function updateDisplayList(param1:Number, param2:Number) : void {
         return;
      }
   }

}