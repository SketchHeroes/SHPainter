package com.reinatech.shpainter.tools.interfaces
{


   public interface ISerializeable
   {
      function saveToolData() : String;

      function loadToolData(param1:String) : void;
   }

}