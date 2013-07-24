package mx.core
{

   use namespace mx_internal;

   public class Singleton extends Object
   {
      public function Singleton() {
         super();
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var classMap:Object = {};

      public static function registerClass(param1:String, param2:Class) : void {
         var _loc3_:Class = classMap[param1];
         if(!_loc3_)
         {
            classMap[param1]=param2;
         }
         return;
      }

      public static function getClass(param1:String) : Class {
         return classMap[param1];
      }

      public static function getInstance(param1:String) : Object {
         var _loc2_:Class = classMap[param1];
         if(!_loc2_)
         {
            throw new Error("No class registered for interface \'" + param1 + "\'.");
         }
         else
         {
            return _loc2_["getInstance"]();
         }
      }
   }

}