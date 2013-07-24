package mx.core
{
   import mx.managers.IToolTipManagerClient;


   public interface INavigatorContent extends IDeferredContentOwner, IToolTipManagerClient
   {
      function get label() : String;

      function get icon() : Class;
   }

}