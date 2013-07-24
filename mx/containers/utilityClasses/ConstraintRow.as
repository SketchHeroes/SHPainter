package mx.containers.utilityClasses
{
   import flash.events.EventDispatcher;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   import flash.events.Event;
   import mx.core.IInvalidating;

   use namespace mx_internal;

   public class ConstraintRow extends EventDispatcher implements IMXMLObject
   {
      public function ConstraintRow() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var contentSize:Boolean = false;

      private var _baseline:Object = "maxAscent:0";

      public function get baseline() : Object {
         return this._baseline;
      }

      public function set baseline(param1:Object) : void {
         if(this._baseline != param1)
         {
            this._baseline=param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("baselineChanged"));
         }
         return;
      }

      private var _container:IInvalidating;

      public function get container() : IInvalidating {
         return this._container;
      }

      public function set container(param1:IInvalidating) : void {
         this._container=param1;
         return;
      }

      mx_internal var _height:Number;

      public function get height() : Number {
         return this._height;
      }

      public function set height(param1:Number) : void {
         if(this.explicitHeight != param1)
         {
            this.explicitHeight=param1;
            if(this._height != param1)
            {
               this._height=param1;
               if(!isNaN(this._height))
               {
                  this.contentSize=false;
               }
               if(this.container)
               {
                  this.container.invalidateSize();
                  this.container.invalidateDisplayList();
               }
               dispatchEvent(new Event("heightChanged"));
            }
         }
         return;
      }

      private var _explicitHeight:Number;

      public function get explicitHeight() : Number {
         return this._explicitHeight;
      }

      public function set explicitHeight(param1:Number) : void {
         if(this._explicitHeight == param1)
         {
            return;
         }
         if(!isNaN(param1))
         {
            this._percentHeight=NaN;
         }
         this._explicitHeight=param1;
         if(this.container)
         {
            this.container.invalidateSize();
            this.container.invalidateDisplayList();
         }
         dispatchEvent(new Event("explicitHeightChanged"));
         return;
      }

      private var _id:String;

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id=param1;
         return;
      }

      private var _explicitMaxHeight:Number;

      public function get maxHeight() : Number {
         return !isNaN(this._explicitMaxHeight)?this._explicitMaxHeight:10000;
      }

      public function set maxHeight(param1:Number) : void {
         if(this._explicitMaxHeight != param1)
         {
            this._explicitMaxHeight=param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("maxHeightChanged"));
         }
         return;
      }

      private var _explicitMinHeight:Number;

      public function get minHeight() : Number {
         return !isNaN(this._explicitMinHeight)?this._explicitMinHeight:0;
      }

      public function set minHeight(param1:Number) : void {
         if(this._explicitMinHeight != param1)
         {
            this._explicitMinHeight=param1;
            if(this.container)
            {
               this.container.invalidateSize();
               this.container.invalidateDisplayList();
            }
            dispatchEvent(new Event("minHeightChanged"));
         }
         return;
      }

      private var _percentHeight:Number;

      public function get percentHeight() : Number {
         return this._percentHeight;
      }

      public function set percentHeight(param1:Number) : void {
         if(this._percentHeight == param1)
         {
            return;
         }
         if(!isNaN(param1))
         {
            this._explicitHeight=NaN;
         }
         this._percentHeight=param1;
         if(!isNaN(this._percentHeight))
         {
            this.contentSize=false;
         }
         if(this.container)
         {
            this.container.invalidateSize();
            this.container.invalidateDisplayList();
         }
         return;
      }

      private var _y:Number;

      public function get y() : Number {
         return this._y;
      }

      public function set y(param1:Number) : void {
         if(param1 != this._y)
         {
            this._y=param1;
            dispatchEvent(new Event("yChanged"));
         }
         return;
      }

      public function initialized(param1:Object, param2:String) : void {
         this.id=param2;
         if(!this.height && !this.percentHeight)
         {
            this.contentSize=true;
         }
         return;
      }

      public function setActualHeight(param1:Number) : void {
         if(this._height != param1)
         {
            this._height=param1;
            dispatchEvent(new Event("heightChanged"));
         }
         return;
      }
   }

}