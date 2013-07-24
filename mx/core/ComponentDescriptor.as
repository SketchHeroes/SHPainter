package mx.core
{

   use namespace mx_internal;

   public class ComponentDescriptor extends Object
   {
      public function ComponentDescriptor(param1:Object) {
         var _loc2_:String = null;
         super();
         for (_loc2_ in param1)
         {
            this[_loc2_]=param1[_loc2_];
         }
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var document:Object;

      public var events:Object;

      public var id:String;

      private var _properties:Object;

      public function get properties() : Object {
         var _loc1_:Array = null;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(this._properties)
         {
            return this._properties;
         }
         if(this.propertiesFactory != null)
         {
            this._properties=this.propertiesFactory.call(this.document);
         }
         if(this._properties)
         {
            _loc1_=this._properties.childDescriptors;
            if(_loc1_)
            {
               _loc2_=_loc1_.length;
               _loc3_=0;
               while(_loc3_ < _loc2_)
               {
                  _loc1_[_loc3_].document=this.document;
                  _loc3_++;
               }
            }
         }
         else
         {
            this._properties={};
         }
         return this._properties;
      }

      public var propertiesFactory:Function;

      public var type:Class;

      public function invalidateProperties() : void {
         this._properties=null;
         return;
      }

      public function toString() : String {
         return "ComponentDescriptor_" + this.id;
      }
   }

}