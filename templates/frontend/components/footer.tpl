{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}
      </div>
    </article>
	</main><!-- _pkp_structure_main -->

  {if $requestedPage !== 'login' && $requestedPage !== 'user'}
    <div class="w-full xl:w-64 xl:sticky xl:top-[4.75rem] xl:h-[calc(100vh-4.75rem)] xl:flex-none overflow-y-auto overflow-x-hidden py-8 xl:py-16 border-t border-slate-200/60 dark:border-slate-800 xl:border-t-0 scrollbar-thin scrollbar-thumb-gray-400 scrollbar-track-gray-200 dark:scrollbar-thumb-gray-600 dark:scrollbar-track-gray-800 mt-12 xl:mt-0">
      <nav aria-label="Sidebar navigation" class="w-full space-y-8">
        {include file="frontend/components/sidebar.tpl"}
      </nav>
    </div>
  {/if}
</div>

{if $requestedPage !== 'login' && $requestedPage !== 'user'}
  <!-- ======= Footer ======= -->
  <footer class="footer bg-slate-50 py-5 bottom-0 text-slate-400 dark:bg-transparent" role="contentinfo">
    <div class="w-full justify-center items-center text-center px-4">
      {if $pageFooter}
        <div class="py-5 text-slate-500 dark:text-slate-400">
            {$pageFooter}
        </div>
      {/if}
      <div class="text-sm">
        <p class="copyright">&copy; Platform & Workflow by: <a href="{url page="about" op="aboutThisPublishingSystem"}" class="hover:text-slate-500">Open Journal Systems</a></p>
        <div class="credits">
          Designed by <a href="https://github.com/madi-nuralin/material" class="hover:text-slate-500">Material Theme</a>
        </div>
      </div>
    </div>
  </footer>

  <!-- Back to top button -->
  <div x-data="{ showTop: false }" @scroll.window="showTop = (window.pageYOffset > 300)">
    <button
      x-show="showTop"
      x-transition:enter="transition ease-out duration-300"
      x-transition:enter-start="opacity-0 translate-y-4"
      x-transition:enter-end="opacity-100 translate-y-0"
      x-transition:leave="transition ease-in duration-200"
      x-transition:leave-start="opacity-100 translate-y-0"
      x-transition:leave-end="opacity-0 translate-y-4"
      @click="window.scrollTo({ top: 0, behavior: 'smooth' })"
      class="fixed bottom-6 right-6 z-50 p-3 rounded-full bg-{$activeTheme->getBaseColour()}-600 text-white shadow-lg hover:bg-{$activeTheme->getBaseColour()}-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-{$activeTheme->getBaseColour()}-500 transition-all duration-200"
      aria-label="{translate key="plugins.themes.material.backToTop"}">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M5 10l7-7m0 0l7 7m-7-7v18"></path>
      </svg>
    </button>
  </div>
{/if}


{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}

</body>
</html>
