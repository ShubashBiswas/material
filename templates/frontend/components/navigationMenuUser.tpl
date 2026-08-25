{**
 * templates/frontend/components/navigationMenuUser.tpl
 *
 * Copyright (c) 2025 Madi N.
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief User navigation menu list for OJS
 *
 * @uses navigationMenu array Hierarchical array of navigation menu item assignments
 * @uses id string Element ID to assign the outer <ul>
 * @uses ulClass string Class name(s) to assign the outer <ul>
 * @uses liClass string Class name(s) to assign all <li> elements
 *}

<ul id="{$id|escape}" role="list" class="{$ulClass|escape} md:flex hidden space-x-2">
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}
		<li class="{$liClass|escape}">
			{material_dropdown}
				{material_dropdown_trigger url="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}"}
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
				{/material_dropdown_trigger}
				{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible()}
					{material_dropdown_body}
						{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
							{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
								{material_dropdown_item url="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="{$liClass|escape}"}
									{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								{/material_dropdown_item}
							{/if}
						{/foreach}
					{/material_dropdown_body}
				{/if}
			{/material_dropdown}
		</li>
	{/foreach}
</ul>

{* Mobile User Navigation Accordion (Pill Button Style) *}
<ul class="{$ulClass|escape} md:hidden space-y-2.5 w-full">
	{foreach key=field item=navigationMenuItemAssignment from=$navigationMenu->menuTree}
		{if !$navigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
			{continue}
		{/if}

		{assign var="hasChildren" value=false}
		{if $navigationMenuItemAssignment->navigationMenuItem->getIsChildVisible() && $navigationMenuItemAssignment->children}
			{assign var="hasChildren" value=true}
		{/if}

		<li class="{$liClass|escape} relative w-full" {if $hasChildren}x-data="{ subOpen: false }"{/if}>
			{if $hasChildren}
				<div class="flex items-center justify-between py-2.5 px-4 rounded-2xl bg-slate-100 dark:bg-slate-800 border border-slate-200/80 dark:border-slate-700/80 text-xs sm:text-sm font-bold text-slate-900 dark:text-white hover:bg-slate-200 dark:hover:bg-slate-700 transition-all cursor-pointer shadow-sm hover:shadow" @click="subOpen = !subOpen">
					<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="flex-1 text-slate-900 dark:text-white hover:text-{$activeTheme->getBaseColour()}-600 dark:hover:text-{$activeTheme->getBaseColour()}-400" @click.stop>
						{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
					</a>
					<button type="button" class="p-1 rounded-lg text-slate-500 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white focus:outline-none" aria-label="Toggle submenu">
						<svg class="w-4 h-4 transition-transform duration-200" :class="{ 'rotate-180': subOpen }" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
						</svg>
					</button>
				</div>
				<ul x-show="subOpen"
					x-transition:enter="transition ease-out duration-200"
					x-transition:enter-start="opacity-0 -translate-y-1"
					x-transition:enter-end="opacity-100 translate-y-0"
					x-transition:leave="transition ease-in duration-150"
					x-transition:leave-start="opacity-100 translate-y-0"
					x-transition:leave-end="opacity-0 -translate-y-1"
					class="mt-2 ml-3 pl-2.5 border-l-2 border-{$activeTheme->getBaseColour()}-500/40 space-y-1.5 text-xs sm:text-sm"
					style="display: none;">
					{foreach key=childField item=childNavigationMenuItemAssignment from=$navigationMenuItemAssignment->children}
						{if $childNavigationMenuItemAssignment->navigationMenuItem->getIsDisplayed()}
							<li class="{$liClass|escape}">
								<a href="{$childNavigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="block py-2 px-3.5 rounded-xl bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-900 dark:text-white hover:text-{$activeTheme->getBaseColour()}-600 dark:hover:text-{$activeTheme->getBaseColour()}-400 hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors font-semibold text-xs sm:text-sm shadow-sm">
									{$childNavigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
								</a>
							</li>
						{/if}
					{/foreach}
				</ul>
			{else}
				<a href="{$navigationMenuItemAssignment->navigationMenuItem->getUrl()}" class="flex items-center justify-between py-2.5 px-4 rounded-2xl bg-slate-100 dark:bg-slate-800 border border-slate-200/80 dark:border-slate-700/80 text-xs sm:text-sm font-bold text-slate-900 dark:text-white hover:text-{$activeTheme->getBaseColour()}-600 dark:hover:text-{$activeTheme->getBaseColour()}-400 hover:bg-slate-200 dark:hover:bg-slate-700 transition-all shadow-sm hover:shadow">
					{$navigationMenuItemAssignment->navigationMenuItem->getLocalizedTitle()}
				</a>
			{/if}
		</li>
	{/foreach}
</ul>
