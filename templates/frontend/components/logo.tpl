{**
 * templates/frontend/components/logo.tpl
 *
 * Copyright (c) 2025 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend logo.
 *}

{if $displayPageHeaderLogo}
	<a href="{url page="index"}" class="flex items-center flex-shrink-0">
		<img
			src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}"
			{if $displayPageHeaderLogo.altText != ''}
				alt="{$displayPageHeaderLogo.altText|escape}"
			{else}
				alt="{$displayPageHeaderTitle|escape}"
			{/if}
			class="h-10 sm:h-12 max-h-12 w-auto max-w-[200px] object-contain flex-shrink-0 transition-all"
		/>
	</a>
{else}
	<a aria-label="Home page" href="{url page="index"}" class="flex items-center flex-shrink-0">
		{include file="frontend/components/ui/material_icon_logo.tpl" small=$small}
	</a>
{/if}