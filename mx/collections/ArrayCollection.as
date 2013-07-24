package mx.collections
{
   import flash.utils.IExternalizable;
   import mx.core.mx_internal;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;

   use namespace mx_internal;

   public class ArrayCollection extends ListCollectionView implements IExternalizable
   {
      public function ArrayCollection(param1:Array=null) {
         super();
         this.source=param1;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public function get source() : Array {
         if((list) && list  is  ArrayList)
         {
            return ArrayList(list).source;
         }
         return null;
      }

      public function set source(param1:Array) : void {
         list=new ArrayList(param1);
         return;
      }

      public function readExternal(param1:IDataInput) : void {
         if(list  is  IExternalizable)
         {
            IExternalizable(list).readExternal(param1);
         }
         else
         {
            this.source=param1.readObject() as Array;
         }
         return;
      }

      public function writeExternal(param1:IDataOutput) : void {
         if(list  is  IExternalizable)
         {
            IExternalizable(list).writeExternal(param1);
         }
         else
         {
            param1.writeObject(this.source);
         }
         return;
      }
   }

}