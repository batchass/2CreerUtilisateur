using System;
using System.ComponentModel;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.WebControls;

namespace _2CreerUtilisateur.VisualWebPart1
{
    [ToolboxItemAttribute(false)]
    public class VisualWebPart1 : WebPart
    {
        // Visual Studio peut mettre à jour automatiquement ce chemin lorsque vous modifiez l'élément de projet Composant Visual Web Part.
        private const string _ascxPath = @"~/_CONTROLTEMPLATES/_2CreerUtilisateur/VisualWebPart1/2CreerUtilisateurUserControl.ascx";

        protected override void CreateChildControls()
        {
            //Control control = Page.LoadControl(_ascxPath);
            //Controls.Add(control);
        }
    }
}
