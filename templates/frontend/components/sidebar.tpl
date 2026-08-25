{**
 * templates/frontend/components/sidebar.tpl
 *
 * Copyright (c) 2025 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Sidebars.
 *}

{if empty($isFullWidth)}
  {capture assign="sidebarCode"}
  {call_hook name="Templates::Common::Sidebar"}{/capture}
  {if $sidebarCode}
    <aside class="pkp_structure_sidebar sidebar flex flex-col space-y-6 w-full max-w-full" aria-label="{translate|escape key="common.navigation.sidebar"}">
      {material_menu aria-label="{translate|escape key="common.navigation.sidebar"}"}
        {$sidebarCode}
      {/material_menu}
    </aside>
  {/if}
{/if}
