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
 * }
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

<body class="bg-white dark:bg-slate-900 pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}" x-data="{ mobileNavOpen: false }">

{if $requestedPage !== 'login' && $requestedPage !== 'user'}

	{* Mobile Navigation Drawer - Placed at root <body> level so backdrop-blur on header cannot constrain it *}
	<div id="mobile-navigation-drawer"
		class="fixed inset-0 z-[99999] flex lg:hidden"
		role="dialog"
		aria-modal="true"
		aria-label="Mobile Navigation"
		x-show="mobileNavOpen"
		x-cloak
		@keydown.window.escape="mobileNavOpen = false"
		style="display: none;">
		
		<!-- Backdrop -->
		<div class="fixed inset-0 bg-slate-950/70 backdrop-blur-sm z-[99998] transition-opacity"
			x-show="mobileNavOpen"
			x-transition:enter="transition ease-out duration-300"
			x-transition:enter-start="opacity-0"
			x-transition:enter-end="opacity-100"
			x-transition:leave="transition ease-in duration-200"
			x-transition:leave-start="opacity-100"
			x-transition:leave-end="opacity-0"
			@click="mobileNavOpen = false">
		</div>

		<!-- Drawer Panel -->
		<div class="relative flex w-80 sm:w-96 max-w-[85vw] flex-col bg-white dark:bg-slate-900 shadow-2xl border-r border-slate-200/80 dark:border-slate-800 text-slate-900 dark:text-white h-screen z-[99999]"
			x-show="mobileNavOpen"
			x-transition:enter="transition ease-out duration-300 transform"
			x-transition:enter-start="-translate-x-full"
			x-transition:enter-end="translate-x-0"
			x-transition:leave="transition ease-in duration-200 transform"
			x-transition:leave-start="translate-x-0"
			x-transition:leave-end="-translate-x-full">
			
			<!-- Drawer Header -->
			<div class="flex items-center justify-between px-5 py-4 border-b border-slate-100 dark:border-slate-800 flex-shrink-0">
				<div class="flex items-center space-x-2.5">
					<div class="h-6 w-1 rounded-full bg-{$activeTheme->getBaseColour()}-500"></div>
					<span class="text-sm font-extrabold text-slate-900 dark:text-white tracking-tight">Navigation</span>
				</div>
				<button type="button"
					class="flex h-8 w-8 items-center justify-center rounded-xl text-slate-500 hover:text-slate-900 dark:text-slate-400 dark:hover:text-white bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 transition-colors focus:outline-none"
					aria-label="Close navigation menu"
					@click="mobileNavOpen = false">
					<svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
						<path d="M6 18L18 6M6 6l12 12"></path>
					</svg>
				</button>
			</div>

			<!-- Drawer Body (Full 100vh height scrollable) -->
			<div class="flex-1 overflow-y-auto p-4 space-y-6 text-slate-900 dark:text-white scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-700">
				<div>
					{capture assign="primaryMenu"}
						{load_menu name="primary" id="navigationPrimary" ulClass="pkp_navigation_primary"}
					{/capture}
					{$primaryMenu}
				</div>
				<div class="pt-4 border-t border-slate-200 dark:border-slate-800">
					{load_menu name="user" id="navigationUser" ulClass="pkp_navigation_user" liClass="profile"}
				</div>
			</div>
		</div>
	</div>

	{if $activeTheme->getOption('announcementText')}
		<div class="bg-{$activeTheme->getBaseColour()}-600 text-white text-xs sm:text-sm font-medium py-2 px-4 text-center shadow-inner relative z-50 flex items-center justify-center space-x-2">
			<svg class="w-4 h-4 inline-block flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"></path></svg>
			<span>{$activeTheme->getOption('announcementText')|escape}</span>
		</div>
	{/if}

	<!-- ======= Header ======= -->
	<header class="sticky top-0 z-50 flex flex-none flex-wrap items-center justify-between bg-white px-4 py-3 shadow-md shadow-slate-900/5 transition duration-500 sm:px-6 lg:px-8 dark:shadow-none dark:bg-slate-900/95 dark:backdrop-blur dark:[@supports(backdrop-filter:blur(0))]:bg-slate-900/75">

		{* 3-Bar Hamburger Trigger Button *}
		<button type="button"
			class="flex h-9 w-9 items-center justify-center rounded-xl bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 text-slate-800 dark:text-white ring-1 ring-slate-900/5 dark:ring-white/10 shadow-sm transition-all focus:outline-none focus:ring-2 focus:ring-{$activeTheme->getBaseColour()}-500 mr-3 lg:hidden"
			aria-label="Open main navigation menu"
			@click="mobileNavOpen = true">
			<svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke="currentColor" class="h-5 w-5 text-slate-800 dark:text-white">
				<path d="M4 6h16M4 12h16M4 18h16"></path>
			</svg>
		</button>

		<div class="relative flex flex-grow basis-0 items-center max-h-12 overflow-hidden mr-4">
			{include file="frontend/components/logo.tpl" small=true}
		</div>

		{if $activeTheme->getOption('primaryMenu') == 'horizontal'}
			<div class="hidden lg:block mx-4 xl:mx-6">
				{* Primary navigation menu for current application *}
				{$primaryMenu}
			</div>
		{/if}

		<div class="flex items-center space-x-3 sm:space-x-4">

			{* Search form *}
			{if $currentContext && $requestedPage !== 'search'}
				<div class="pkp_navigation_search_wrapper">
					<a href="{url page="search"}" class="flex h-8 w-8 items-center justify-center rounded-xl shadow-md shadow-black/5 ring-1 ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5" title="{translate key="common.search"}">
						{include file="frontend/components/ui/material_icon_search.tpl"}
					</a>
				</div>
			{/if}
			{include file="frontend/components/ui/material_theme_selector.tpl"}

			{* Profile Icon Dropdown / Login Button (Icon only) *}
			{if $isUserLoggedIn}
				<div class="relative" x-data="{ userOpen: false }">
					<button type="button" @click="userOpen = !userOpen" @click.away="userOpen = false" class="flex h-8 w-8 items-center justify-center rounded-xl bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 text-slate-700 dark:text-slate-200 transition-colors shadow-md shadow-black/5 ring-1 ring-black/5 dark:ring-inset dark:ring-white/5 focus:outline-none" aria-label="User menu">
						<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
					</button>
					<div x-show="userOpen" x-transition:enter="transition ease-out duration-150" x-transition:enter-start="opacity-0 scale-95 -translate-y-1" x-transition:enter-end="opacity-100 scale-100 translate-y-0" x-transition:leave="transition ease-in duration-100" x-transition:leave-start="opacity-100 scale-100 translate-y-0" x-transition:leave-end="opacity-0 scale-95 -translate-y-1" class="absolute right-0 mt-2 w-48 rounded-2xl bg-white dark:bg-slate-800 shadow-xl border border-slate-200/80 dark:border-slate-700/80 p-1.5 z-50" style="display: none;">
						<a href="{url page="dashboard"}" class="flex items-center space-x-2 px-3 py-2 rounded-xl text-xs sm:text-sm font-medium text-slate-700 dark:text-slate-200 hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors">
							<svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"></path></svg>
							<span>{translate key="navigation.dashboard"}</span>
						</a>
						<a href="{url page="user" op="profile"}" class="flex items-center space-x-2 px-3 py-2 rounded-xl text-xs sm:text-sm font-medium text-slate-700 dark:text-slate-200 hover:bg-slate-100 dark:hover:bg-slate-700 transition-colors">
							<svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
							<span>{translate key="user.profile"}</span>
						</a>
						<div class="my-1 border-t border-slate-100 dark:border-slate-700/60"></div>
						<a href="{url page="login" op="signOut"}" class="flex items-center space-x-2 px-3 py-2 rounded-xl text-xs sm:text-sm font-medium text-rose-600 dark:text-rose-400 hover:bg-rose-50 dark:hover:bg-rose-950/40 transition-colors">
							<svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
							<span>{translate key="user.logOut"}</span>
						</a>
					</div>
				</div>
			{else}
				<a href="{url page="login"}" class="flex h-8 w-8 items-center justify-center rounded-xl bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 text-slate-700 dark:text-slate-200 transition-colors shadow-md shadow-black/5 ring-1 ring-black/5 dark:ring-inset dark:ring-white/5" title="{translate key="user.login"}">
					<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"></path></svg>
				</a>
			{/if}

		</div>
	</header>

	{if $requestedPage == 'index' || $requestedPage == ''}
		{if $currentContext}
			{include file="frontend/components/headerSection.tpl"}
		{/if}
	{/if}

{/if}

<div class="pkp_structure_content w-full flex-grow flex flex-col xl:flex-row justify-between gap-8 xl:gap-12 max-w-8xl mx-auto px-4 sm:px-6 lg:px-8 xl:px-12 py-8">
	<main class="w-full flex-grow min-w-0">
