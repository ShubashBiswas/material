{**
 * templates/frontend/pages/article.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display landing page for a single article.
 *
 * @uses $article Submission This article
 * @uses $publication Publication The publication being displayed
 * @uses $firstPublication Publication The first published version of this article
 * @uses $currentPublication Publication The most recently published version of this article
 * @uses $issue Issue The issue this article is assigned to
 * @uses $section Section The journal section this article is assigned to
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$article->getCurrentPublication()->getLocalizedFullTitle(null, 'html')|strip_unsafe_html}

<div class="page page_article w-full space-y-6">

	{* Breadcrumbs Navigation *}
	<div class="mb-4">
		{if $section}
			{include file="frontend/components/breadcrumbs_article.tpl" currentTitle=$section->getLocalizedTitle()}
		{else}
			{include file="frontend/components/breadcrumbs_article.tpl" currentTitleKey="common.publication"}
		{/if}
	</div>

	{* Main Article Object *}
	{include file="frontend/objects/article_details.tpl"}

	{call_hook name="Templates::Article::Footer::PageFooter"}

</div>

{include file="frontend/components/footer.tpl"}
