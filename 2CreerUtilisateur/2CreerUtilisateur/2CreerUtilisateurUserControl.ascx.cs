using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;
using Microsoft.SharePoint.Client;
using Microsoft.SharePoint.WebPartPages.Communication;
using Microsoft.SharePoint.Security;
using Microsoft.SharePoint.Utilities;

namespace _2CreerUtilisateur.VisualWebPart1
{
    public partial class VisualWebPart1UserControl : UserControl
    {
        SPContext spCtx = SPContext.Current;

        //info de l'utilisateur demandeur
        string userName;
        string userFonct;
        string userService;
        DateTime dateDem = DateTime.Now;
        //titre liste pour dropDown
        string list1 = "Lieu de travail";
        string list2 = "Statut";
        string list3 = "Jour de la semaine";
        string list4 = "Portee du telephone";
        string list5 = "Poste de travail";
        string list6 = "Services C.A.S.A.";
        //champ dans lequel se trouve l'info à recuperer
        string champ1 = "Lieu";
        string champ2 = "Statut";
        string champ3 = "Jour";
        string champ4 = "Portee";
        string champ5 = "Poste";
        string champ6 = "Titre";
        //liste du formulaire traité
        SPListItem ligneInfo;
        // etat de la demande
        string etatDemande;
        //url du serveur
        string url;
        // variable de recuperation du login
        string login = "";
        List<TreeViewItem> treeViewList;

        //================================================================ Main LOAD ========================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            // recuperation de l'url du serveur local
            url = SPContext.Current.Web.Url;
            login = Request.QueryString["nigol"];

            // requete CAML sur l'etat de la demande ainsi que l'identité du demandeur
            string caml = "<Where><And><Eq><FieldRef Name=\"Title\" /><Value Type=\"Text\">Etape1</Value></Eq><Eq><FieldRef Name=\"Login\" /><Value Type=\"Text\">" + login + "</Value></Eq></And></Where>";

            // initialisation de la liste a traité
            ligneInfo = initFormulaire(caml, "Demande Nouvel Arrivant");

            // recuperation de l'etat de la demande
            etatDemande = ligneInfo["Titre"].ToString();

            // recuperation de l'utilisateur actuel
            RecupInfoContextDemande();

            // Affichage donnée utilisateur
            lblNomComplet.Text = userName;
            lblDemFonction.Text = userFonct;
            lblDemService.Text = userService;
            dtEntree.SelectedDate = DateTime.Now;
            
            // Affichage donnée bénéficiaire
            lblNom.Text = ligneInfo["Nom bénéficiaire"].ToString();
            lblPrenom.Text = ligneInfo["Prénom bénéficiaire"].ToString();
            lblLogin.Text = ligneInfo["Login"].ToString();


            // remplissage DropDownList
            if (Page.IsPostBack == false)
            {
                remplirDropDownList(ddLieuTravail, spCtx.Web.Lists[list1], champ1);
                remplirDropDownList(ddStatut, spCtx.Web.Lists[list2], champ2);
                remplirDropDownList(ddJourDebut, spCtx.Web.Lists[list3], champ3);
                remplirDropDownList(ddJourFin, spCtx.Web.Lists[list3], champ3, 4);
                remplirDropDownList(ddTelPortee, spCtx.Web.Lists[list4], champ4);
                remplirDropDownList(ddChoixPoste, spCtx.Web.Lists[list5], champ5);
                remplirTreeview(treeService, spCtx.Web.Lists[list6], champ6);
            }

            // demande validation des bouton
            //Envoyer.Attributes.Add("onclick", "javascript: return confirm('Etes-vous sûr de vouloir effectuer cette demande ?');");
        }

        //========================================================= remplirTreeview() ============================================================
        private void remplirTreeview(TreeView tree, SPList list, string libelle)
        {
            treeViewList = new List<TreeViewItem>();
            SPQuery myquery = new SPQuery();
            myquery.Query = "";
            SPListItemCollection items = list.GetItems(myquery);
            foreach (SPListItem item in items)
            {
                treeViewList.Add(new TreeViewItem()
                {
                    ParentID = item["Service Parent"].ToString(),
                    ID = item[libelle].ToString(),
                    Text = item[libelle].ToString()
                });
            }
            PopulateTreeView("CASA", null);
            tree.CollapseAll();
        }

        //========================================================== PopulateTreeView() ===========================================================
        private void PopulateTreeView(string parentId, TreeNode parentNode)
        {
            var filteredItems = treeViewList.Where(item =>
                                        item.ParentID == parentId);

            TreeNode childNode;
            foreach (var i in filteredItems.ToList())
            {
                childNode = new TreeNode(i.Text, null, null, null, "_self");
                if (parentNode == null)
                {
                    treeService.Nodes.Add(childNode);
                }
                else
                {
                    parentNode.ChildNodes.Add(childNode);
                }
                PopulateTreeView(i.ID, childNode);
            }
        }

        //======================================================== remplirDropDownList() ==========================================================
        public void remplirDropDownList(DropDownList ddl, SPList list, string libelle)
        {
            SPQuery myquery = new SPQuery();
            myquery.Query = "";
            SPListItemCollection items = list.GetItems(myquery);
            foreach (SPListItem item in items)
            {
                ddl.Items.Add(item[libelle].ToString());
            }
        }

        //=================================================== remplirDropDownList Surcharg()e =====================================================
        public void remplirDropDownList(DropDownList ddl, SPList list, string libelle, int indexSelected)
        {
            SPQuery myquery = new SPQuery();
            myquery.Query = "";
            SPListItemCollection items = list.GetItems(myquery);
            foreach (SPListItem item in items)
            {
                ddl.Items.Add(item[libelle].ToString());
            }
            ddl.SelectedIndex = indexSelected;
        }

        //====================================================== RecupInfoContextDemande() =======================================================
        public void RecupInfoContextDemande()
        {
            // recupere le login de la personne connecter, et en deduit son nom, son prenom, son service, et sa fonction
            string[] stringSep = new string[] { "\\" };
            string[] result;
            SPWeb currentWeb = SPContext.Current.Web;

            result = currentWeb.CurrentUser.LoginName.Split(stringSep, StringSplitOptions.None);
            SPList list = spCtx.Web.Lists["Contacts C.A.S.A."];
            SPQuery myquery = new SPQuery();
            myquery.Query = "";
            SPListItemCollection items = list.GetItems(myquery);

            foreach (SPListItem item in items)
            {
                if (item["Login"].ToString() == result[1])
                {
                    userName = item["Nom complet"].ToString();
                    userFonct = item["Fonction"].ToString();
                    userService = item["Service"].ToString();
                }
            }

            lblNomComplet.Text = userName;
            lblDemFonction.Text = userFonct;
            lblDemService.Text = userService;
            lblDateDemande.Text = dateDem.Date.Day.ToString() + "/" + dateDem.Date.Month.ToString() + "/" + dateDem.Date.Year.ToString();
        }

        //======================================================== initFormulaire() ==========================================================
        public SPListItem initFormulaire(string caml, string NameList)
        {

            SPListItem listRet;
            SPListItemCollection collItem;
            SPList list = spCtx.Web.Lists[NameList];
            SPQuery queryMy = new SPQuery();
            int existLigne;
            //initialisation de la requete de recherche formulaire actuel
            queryMy.Query = caml;
            // execution requete
            existLigne = list.GetItems(queryMy).Count;
            if (existLigne != 0)
            {
                collItem = list.GetItems(queryMy);
                //recuperation resultat
                listRet = null;
                foreach (SPListItem item in collItem)
                {
                    listRet = item;
                }
            }
            else
            {
                Response.Redirect(url + "/SitePages/Nouvel arrivant.aspx");
                listRet = null;
            }
            // renvoi resultat
            return listRet;
        }

        //=========================================================== NeverNull() ================================================================
        // procedure qui retourne "" si le string passer en parametre est null
        public string NeverNull(string i)
        {
            if (i == null)
            {
                i = "";
            }
            return i;
        }

        //======================================================== event ===================================================

        //=================================================================================================
        //====================== Clique sur bouton Envoyer ================================================
        //=================================================================================================
        protected void Envoyer_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)// la validation est bonne ...
            {
                if (lblService.Text != null || lblService.Text != "")
                {
                    // Si valiadtion est true alors, on enregistre la demande dans la liste sharepoint

                    // on rempli l'item recuperer dans ligneInfo
                    ligneInfo["Titre"] = "Etape2";
                    ligneInfo["date d'entrée"] = NeverNull(dtEntree.SelectedDate.ToString());
                    ligneInfo["date de sortie"] = NeverNull(dtSortie.SelectedDate.ToString());
                    ligneInfo["Statut"] = NeverNull(ddStatut.SelectedValue.ToString());
                    ligneInfo["Fonction"] = NeverNull(txtFonction.Text);
                    ligneInfo["Lieu de travail"] = NeverNull(ddLieuTravail.SelectedValue.ToString());
                    ligneInfo["N° bureau"] = NeverNull(txtBureau.Text);
                    ligneInfo["Remplacement"] = NeverNull(rdAgentRemplace.SelectedValue.ToString());
                    ligneInfo["Agent Remplacé"] = NeverNull(txtAgentRemplace.Text);
                    ligneInfo["Téléphone fixe"] = NeverNull(rdTelephonieFixe.SelectedValue.ToString());
                    ligneInfo["Téléphone portable"] = NeverNull(rdTelPortable.SelectedValue.ToString());
                    ligneInfo["Justification téléphone portable"] = NeverNull(txtTelPortable.Text);
                    ligneInfo["Jour d'utilisation"] = "du " + ddJourDebut.SelectedValue.ToString() + " au " + ddJourFin.SelectedValue.ToString();
                    ligneInfo["Portée d'utilisation"] = NeverNull(ddTelPortee.SelectedValue.ToString());
                    ligneInfo["Poste de travail"] = NeverNull(ddChoixPoste.SelectedValue.ToString());
                    ligneInfo["Justification du poste de travail"] = NeverNull(txtStationGraph.Text);
                    ligneInfo["Accés Internet"] = NeverNull(rdAccesInternet.SelectedValue.ToString());
                    ligneInfo["Accés Mail"] = NeverNull(rdAdresseMail.SelectedValue.ToString());
                    ligneInfo["Accés à Post-Office"] = NeverNull(rdPostOffice.SelectedValue.ToString());
                    ligneInfo["Accés à Actes-Office"] = NeverNull(rdActesOffice.SelectedValue.ToString());
                    ligneInfo["Accés au logiciel Finance"] = NeverNull(rdLogicielFinance.SelectedValue.ToString());
                    ligneInfo["Accés à la saisie information DRH"] = NeverNull(rdSaisiInfoDRH.SelectedValue.ToString());
                    ligneInfo["Besoins spécifiques"] = NeverNull(txtBesoinsSpe.Text);
                    ligneInfo["Service"] = lblService.Text;
                    //mis a jour de l'item dans la base SP
                    ligneInfo.Update();

                    //redirection vers accueil
                    Response.Redirect(url + "/SitePages/Accueil.aspx");
                }
            }
        }

        //=================================================================================================
        //====================== Modif selection rdAgentRempalce ==========================================
        //=================================================================================================
        protected void rdAgentRemplace_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdAgentRemplace.SelectedIndex == 0)
            {
                lblAgentRemplace.Visible = true;
                txtAgentRemplace.Visible = true;
            }
            else
            {
                lblAgentRemplace.Visible = false;
                txtAgentRemplace.Visible = false;
            }
        }

        //=================================================================================================
        //====================== Modif selection rdTelPortable ============================================
        //=================================================================================================
        protected void rdTelPortable_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdTelPortable.SelectedIndex == 0)
            {
                lblTelPortable.Visible = true;
                txtTelPortable.Visible = true;
            }
            else
            {
                lblTelPortable.Visible = false;
                txtTelPortable.Visible = false;
            }
        }

        //=================================================================================================
        //====================== Modif selection rdChoixPoste =============================================
        //=================================================================================================
        protected void ddChoixPoste_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddChoixPoste.SelectedIndex == 4 || ddChoixPoste.SelectedIndex == 3)
            {
                lblStationGraph.Visible = true;
                txtStationGraph.Visible = true;
            }
            else
            {
                lblStationGraph.Visible = false;
                txtStationGraph.Visible = false;
            }
        }

        //=================================================================================================
        //====================== Modif selection TreeView =================================================
        //=================================================================================================
        protected void treeService_SelectedNodeChanged(object sender, EventArgs e)
        {
            lblService.Text = treeService.SelectedNode.Text;
        }

    }

    public class TreeViewItem
    {
        public string ID { get; set; }
        public string ParentID { get; set; }
        public string Text { get; set; }
    }

}
