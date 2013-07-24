package mx.collections
{
   import mx.rpc.IResponder;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ItemResponder extends Object implements IResponder
   {
      public function ItemResponder(param1:Function, param2:Function, param3:Object=null) {
         super();
         this._resultHandler=param1;
         this._faultHandler=param2;
         this._token=param3;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public function result(param1:Object) : void {
         this._resultHandler(param1,this._token);
         return;
      }

      public function fault(param1:Object) : void {
         this._faultHandler(param1,this._token);
         return;
      }

      private var _resultHandler:Function;

      private var _faultHandler:Function;

      private var _token:Object;
   }

}