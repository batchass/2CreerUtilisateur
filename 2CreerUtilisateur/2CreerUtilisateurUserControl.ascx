<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %> 
<%@ Register Tagprefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %> 
<%@ Register Tagprefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="2CreerUtilisateurUserControl.ascx.cs" Inherits="_2CreerUtilisateur.VisualWebPart1.VisualWebPart1UserControl" %>
        <div>
            <p>
                <asp:Image ID="Image1" runat="server" AlternateText="Fiche Nouvel Arrivant" ImageUrl="~/_layouts/images/2CreerUtilisateur/_nouvelarrivantentete.jpg" />
            </p>
            <p class="MsoBodyText" style="margin: 0cm 0cm 6pt">
                <span style="font-size: 14pt; font-family: 'Myriad Pro','sans-serif'">Dans le cadre
                    d’un nouvel arrivant au sein de votre service, d’un besoin nouveau, vous êtes amenés
                    à demander au Service Informatique &amp; Télécoms le matériel nécessaire à cette
                    personne pour la bonne réalisation de son travail. </span>
            </p>
            <p class="MsoBodyText" style="margin: 0cm 0cm 6pt">
                <span style="font-size: 14pt; font-family: 'Myriad Pro','sans-serif'">A cet effet je
                    vous remercie de compléter la fiche ci-dessous : </span>
            </p>
            <p class="MsoBodyText" style="margin: 0cm 0cm 6pt">
                <span style="font-size: 14pt; font-family: 'Myriad Pro','sans-serif'">Ces renseignements
                    nous sont nécessaires, afin de mettre en place les outils informatiques et téléphoniques
                    correspondant aux besoins réels de l’agent. </span>
            </p>
            <div>
                <table style="border-top-style: none; border-right-style: none; border-left-style: none;
                    border-bottom-style: solid">
                    <tr>
                        <td style="width: 150px">
                            <b>Demandeur</b>
                        </td>
                        <td style="width: 440px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Nom du demandeur :
                        </td>
                        <td style="width: 440px">
                            <asp:Label ID="lblNomComplet" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Fonction :
                        </td>
                        <td style="width: 440px">
                            <asp:Label ID="lblDemFonction" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Service :
                        </td>
                        <td style="width: 440px">
                            <asp:Label ID="lblDemService" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Date de la demande :
                        </td>
                        <td style="width: 440px">
                            <asp:Label ID="lblDateDemande" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
                <table style="border-top-style: none; border-right-style: none; border-left-style: none;
                    border-bottom-style: solid">
                    <tr>
                        <td style="width: 150px">
                            <b>Bénéficiaire</b>
                        </td>
                        <td style="width: 440px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Nom du bénéficiaire :
                        </td>
                        <td style="width: 440px">
                            <asp:Label ID="lblNom" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Prenom :
                        </td>
                        <td style="width: 440px">
                            <asp:Label ID="lblPrenom" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Login :
                        </td>
                        <td style="width: 440px">
                            <asp:Label ID="lblLogin" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="150px">
                            Date entrée :
                        </td>
                        <td class="440px">
                            <SharePoint:DateTimeControl ID="dtEntree" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Date sortie (s'il y a lieu) :
                        </td>
                        <td style="width: 440px">
                            <SharePoint:DateTimeControl ID="dtSortie" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Fonction :
                        </td>
                        <td style="width: 440px">
                            <asp:TextBox ID="txtFonction" runat="server" Width="250px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtFonction"
                                ErrorMessage="Veuillez entrez une Fonction *">
                                        Veuillez entrez une Fonction *</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Service :
                        </td>
                        <td style="width: 440px">
                            <asp:TreeView ID="treeService" runat="server" 
                                onselectednodechanged="treeService_SelectedNodeChanged">
                            </asp:TreeView>
                            <asp:Label ID="lblService" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Statut :
                        </td>
                        <td style="width: 440px">
                            <asp:DropDownList ID="ddStatut" runat="server">
                                <asp:ListItem Selected="True">Choissisez un statut</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ddStatut"
                                ErrorMessage="*" InitialValue="Choissisez un statut">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Lieu de travail :
                        </td>
                        <td style="width: 440px">
                            <asp:DropDownList ID="ddLieuTravail" runat="server">
                                <asp:ListItem Selected="True">Choissisez un lieu de travail</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddLieuTravail"
                                ErrorMessage="  *" InitialValue="Choissisez un lieu de travail">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            N° de bureau :
                        </td>
                        <td style="width: 440px">
                            <asp:TextBox ID="txtBureau" runat="server" Width="250px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtBureau"
                                ErrorMessage="Veuillez entrez un numéro *">
                                        Veuillez entrez un numéro *</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            S'agit-il d'un remplacement :
                        </td>
                        <td style="width: 440px">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="rdAgentRemplace" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rdAgentRemplace_SelectedIndexChanged"
                                        RepeatDirection="Horizontal">
                                        <asp:ListItem>Oui</asp:ListItem>
                                        <asp:ListItem Selected="True">Non</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:Label ID="lblAgentRemplace" runat="server" Style="text-decoration: underline"
                                        Visible="False">Nom de l'agent remplacé :</asp:Label>
                                    <br />
                                    <asp:TextBox ID="txtAgentRemplace" runat="server" EnableViewState="False" Visible="False"
                                        Width="429px"></asp:TextBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
                <table style="border-top-style: none; border-right-style: none; border-left-style: none;
                    border-bottom-style: solid">
                    <tr>
                        <td style="width: 150px">
                            <b>Besoins en téléphonie</b>
                        </td>
                        <td style="width: 440px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Poste fixe :
                        </td>
                        <td style="width: 440px">
                            <asp:RadioButtonList ID="rdTelephonieFixe" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Oui</asp:ListItem>
                                <asp:ListItem>Oui avec SDA*</asp:ListItem>
                                <asp:ListItem Selected="True">Non</asp:ListItem>
                            </asp:RadioButtonList>
                            * SDA: Possibilité d’être joint de l’extérieur sans passer par le standard
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Téléphone Portable :
                        </td>
                        <td style="width: 440px">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="rdTelPortable" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rdTelPortable_SelectedIndexChanged"
                                        RepeatDirection="Horizontal">
                                        <asp:ListItem>Oui</asp:ListItem>
                                        <asp:ListItem Selected="True">Non</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:Label ID="lblTelPortable" runat="server" Style="text-decoration: underline"
                                        Visible="False">Justification :</asp:Label>
                                    <br />
                                    <asp:TextBox ID="txtTelPortable" runat="server" EnableViewState="False" Visible="False"
                                        Width="429px"></asp:TextBox>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Utilisation:
                        </td>
                        <td style="width: 440px">
                            <asp:DropDownList ID="ddJourDebut" runat="server">
                            </asp:DropDownList>
                            <b>au</b>
                            <asp:DropDownList ID="ddJourFin" runat="server">
                            </asp:DropDownList>
                            <br />
                            <br />
                            <asp:DropDownList ID="ddTelPortee" runat="server">
                                <asp:ListItem Selected="True">Selectionnez une option</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddTelPortee"
                                ErrorMessage="*" InitialValue="Selectionnez une option">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
                <table style="border-top-style: none; border-right-style: none; border-left-style: none;
                    border-bottom-style: solid">
                    <tr>
                        <td style="width: 150px">
                            <b>Besoins en matériel informatique</b>
                        </td>
                        <td style="width: 440px">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <em>La dotation de base est un poste informatique équipé de la suite Office, Word Excel
                                Outlook et PowerPoint.</em>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Choix poste de travail :
                        </td>
                        <td style="width: 440px">
                            <asp:DropDownList ID="ddChoixPoste" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddChoixPoste_SelectedIndexChanged">
                                <asp:ListItem Selected="True">Selectionner un poste</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddChoixPoste"
                                ErrorMessage="*" InitialValue="Selectionner un poste">*</asp:RequiredFieldValidator>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Label ID="lblStationGraph" runat="server" Style="text-decoration: underline"
                                        Visible="False">Justification :</asp:Label>
                                    <br />
                                    <asp:TextBox ID="txtStationGraph" runat="server" EnableViewState="False" Visible="False"
                                        Width="429px"></asp:TextBox>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddChoixPoste" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Accès Internet :
                        </td>
                        <td style="width: 440px">
                            <asp:RadioButtonList ID="rdAccesInternet" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Oui</asp:ListItem>
                                <asp:ListItem Selected="True">Non</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Adresse Mail :
                        </td>
                        <td style="width: 440px">
                            <asp:RadioButtonList ID="rdAdresseMail" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Oui</asp:ListItem>
                                <asp:ListItem Selected="True">Non</asp:ListItem>
                            </asp:RadioButtonList>
                            pas de boite mail pour les stagiaires de moins de 6 mois
                        </td>
                    </tr>
                </table>
                <table style="border-top-style: none; border-right-style: none; border-left-style: none;
                    border-bottom-style: solid">
                    <tr>
                        <td style="width: 150px">
                            <b>Besoin en logiciel informatique</b>
                        </td>
                        <td style="width: 440px">
                            <b>(Aprés validation des directions concernées)</b>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Accès à Post-Office :
                        </td>
                        <td style="width: 440px">
                            <asp:RadioButtonList ID="rdPostOffice" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Rédacteur</asp:ListItem>
                                <asp:ListItem>Consultant</asp:ListItem>
                                <asp:ListItem Selected="True">Non</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Accès à Actes-Office :
                        </td>
                        <td style="width: 440px">
                            <asp:RadioButtonList ID="rdActesOffice" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Rédacteur</asp:ListItem>
                                <asp:ListItem>Consultant</asp:ListItem>
                                <asp:ListItem Selected="True">Non</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Accès au logiciel Finance :
                        </td>
                        <td style="width: 440px">
                            <asp:RadioButtonList ID="rdLogicielFinance" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Oui</asp:ListItem>
                                <asp:ListItem Selected="True">Non</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            Accès à la saisie d'information DRH :
                        </td>
                        <td style="width: 440px">
                            <asp:RadioButtonList ID="rdSaisiInfoDRH" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem>Oui</asp:ListItem>
                                <asp:ListItem Selected="True">Non</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px">
                            <b>Besoins spécifiques :</b>
                            <br />
                            (à détailler)
                        </td>
                        <td style="width: 440px">
                            <asp:TextBox ID="txtBesoinsSpe" runat="server" Height="37px" Width="429px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <br />
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="Envoyer" runat="server" OnClick="Envoyer_Click" Text="Demander la validation" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
<p>
    version 1.0.5</p>

