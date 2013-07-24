package mx.binding
{
   import mx.rpc.IResponder;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class EvalBindingResponder extends Object implements IResponder
   {
      public function EvalBindingResponder(param1:Binding, param2:Object) {
         super();
         this.binding=param1;
         this.object=param2;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var binding:Binding;

      private var object:Object;

      public function result(param1:Object) : void {
         this.binding.execute(this.object);
         return;
      }

      public function fault(param1:Object) : void {
         return;
      }
   }

}