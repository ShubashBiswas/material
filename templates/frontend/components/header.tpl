{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
{strip}
	{* Determine whether a logo or title string is being displayed *}
	{assign var="showingLogo" value=true}
	{if !$displayPageHeaderLogo}
		{assign var="showingLogo" value=false}
	{/if}
{/strip}
<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}"
	xml:lang="{$currentLocale|replace:"_":"-"}"
	class="font-{$activeTheme->getOption('fontFamily')}" 
	{literal}
  		x-data="{ darkMode: localStorage.getItem('darkMode') || 'light' }" 
  		x-init="$watch('darkMode', val => localStorage.setItem('darkMode', val))" 
  		:class="{'dark': darkMode === 'dark' || (darkMode === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches)}"
  	{/literal}>


{if !$pageTitleTranslated}
	{capture assign="pageTitleTranslated"}
		{translate key=$pageTitle}
	{/capture}
{/if}
{include file="frontend/components/headerHead.tpl"}

<body class="bg-white dark:bg-slate-900 pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">

{if $requestedPage !== 'login' && $requestedPage !== 'user'}

	{if $activeTheme->getOption('announcementText')}
		<div class="bg-{$activeTheme->getBaseColour()}-600 text-white text-xs sm:text-sm font-medium py-2 px-4 text-center shadow-inner relative z-50 flex items-center justify-center space-x-2">
			<svg class="w-4 h-4 inline-block flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path></svg>
			<span>{$activeTheme->getOption('announcementText')|escape}</span>
		</div>
	{/if}

	<!-- ======= Header ======= -->
	<header class="sticky top-0 z-50 flex flex-none flex-wrap items-center justify-between bg-white px-4 py-5 shadow-md shadow-slate-900/5 transition duration-500 sm:px-6 lg:px-8 dark:shadow-none dark:bg-slate-900/95 dark:backdrop-blur dark:[@supports(backdrop-filter:blur(0))]:bg-slate-900/75">

		{material_sidestack class="flex xl:hidden"}
			<div class="space-y-9">
				<div class="mt-5 lg:hidden">
					{capture assign="primaryMenu"}
						{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
					{/capture}
					{$primaryMenu}
				</div>
				<div class="md:hidden">
					{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
				</div>
			</div>
		{/material_sidestack}

		<div class="relative flex flex-grow basis-0 items-center">
			{include file="frontend/components/logo.tpl" small=true}
		</div>

		{if $activeTheme->getOption('primaryMenu') == 'horizontal'}
			<div class="hidden lg:block">
				{* Primary navigation menu for current application *}
				{$primaryMenu}
			</div>
		{/if}

		<div class="flex items-center space-x-2">
			{* Search form *}
			{if $currentContext && $requestedPage !== 'search'}
				<div class="pkp_navigation_search_wrapper">
					<a href="{url page="search"}" class="flex h-8 w-8 items-center justify-center rounded-xl shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5">
						{include file="frontend/components/ui/material_icon_search.tpl"}
					</a>
				</div>
			{/if}
			{include file="frontend/components/ui/material_theme_selector.tpl"}
			{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user hidden md:flex" liClass="profile"}
		</div>
	</header>

	{if $requestedPage == 'index' || $requestedPage == ''}
		{if $currentContext}
			{include file="frontend/components/headerSection.tpl"}
		{/if}
	{/if}

	{capture assign="primaryMenu"}
		{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
	{/capture}

	<div class="relative mx-auto flex flex-col xl:flex-row w-full flex-auto justify-between gap-8 xl:gap-12 px-4 sm:px-6 lg:px-8 xl:px-12">
		{if $activeTheme->getOption('primaryMenu') == 'vertical'}
			<div class="hidden lg:relative lg:block lg:flex-none">
				<div class="sticky top-[4.75rem] h-[calc(100vh-4.75rem)] w-64 xl:w-72 overflow-y-auto overflow-x-hidden py-8 xl:py-16 scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-200 dark:scrollbar-thumb-gray-600 dark:scrollbar-track-gray-800">
					<nav class="text-base lg:text-sm">
						{* Primary navigation menu for current application *}
						{$primaryMenu}
					</nav>
				</div>
			</div>
		{/if}

		{* Wrapper for page content and sidebars *}
		{if $isFullWidth}
			{assign var=hasSidebar value=0}
		{/if}

		{* Main *}
		<main class="min-w-0 w-full flex-auto py-8 lg:py-16 dark:text-white">
			<a id="pkp_content_main"></a>
			<article>
				<div class="prose prose-slate max-w-none w-full prose-a:text-{$activeTheme->getBaseColour()}-400 dark:prose-a:text-{$activeTheme->getBaseColour()}-400 dark:prose-invert dark:text-slate-400 dark:prose-lead:text-slate-400 prose-headings:font-normal">
{else}
	<main class="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100 dark:bg-gray-900 dark:text-white" role="main">
		<a id="pkp_content_main"></a>
{/if}
