package mx.core
{
   import flash.display.DisplayObject;
   import flash.geom.Point;

   use namespace mx_internal;

   public class ContainerRawChildrenList extends Object implements IChildList
   {
      public function ContainerRawChildrenList(param1:Container) {
         super();
         this.owner=param1;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var owner:Container;

      public function get numChildren() : int {
         return this.owner.$numChildren;
      }

      public function addChild(param1:DisplayObject) : DisplayObject {
         return this.owner.rawChildren_addChild(param1);
      }

      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject {
         return this.owner.rawChildren_addChildAt(param1,param2);
      }

      public function removeChild(param1:DisplayObject) : DisplayObject {
         return this.owner.rawChildren_removeChild(param1);
      }

      public function removeChildAt(param1:int) : DisplayObject {
         return this.owner.rawChildren_removeChildAt(param1);
      }

      public function getChildAt(param1:int) : DisplayObject {
         return this.owner.rawChildren_getChildAt(param1);
      }

      public function getChildByName(param1:String) : DisplayObject {
         return this.owner.rawChildren_getChildByName(param1);
      }

      public function getChildIndex(param1:DisplayObject) : int {
         return this.owner.rawChildren_getChildIndex(param1);
      }

      public function setChildIndex(param1:DisplayObject, param2:int) : void {
         this.owner.rawChildren_setChildIndex(param1,param2);
         return;
      }

      public function getObjectsUnderPoint(param1:Point) : Array {
         return this.owner.rawChildren_getObjectsUnderPoint(param1);
      }

      public function contains(param1:DisplayObject) : Boolean {
         return this.owner.rawChildren_contains(param1);
      }
   }

}