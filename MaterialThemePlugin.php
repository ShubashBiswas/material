<?php

/**
 * @file plugins/themes/material/MaterialThemePlugin.inc.php
 *
 * Copyright (c) 2021 Madi Nuralin
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @class MaterialThemePlugin
 *
 * @brief Material theme
 */

namespace APP\plugins\themes\material;

use APP\core\Application;
use APP\file\PublicFileManager;
use PKP\config\Config;
use PKP\core\PKPSessionGuard;
use APP\template\TemplateManager;
use PKP\plugins\Hook;


class MaterialThemePlugin extends \PKP\plugins\ThemePlugin
{
    /**
     * @copydoc ThemePlugin::isActive()
     */
    public function isActive() {
        if (PKPSessionGuard::isSessionDisable()) {
            return true;
        }
        return parent::isActive();
    }

    /**
     * Initialize the theme's styles, scripts and hooks. This is run on the
     * currently active theme and it's parent themes.
     *
     */
    public function init() {

        // Register theme options
        $this->addOption('showDescriptionInJournalIndex', 'FieldOptions', [
            'label' => __('manager.setup.contextSummary'),
                'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.material.option.showDescriptionInJournalIndex.option'),
                ],
            ],
            'default' => false,
        ]);

        $this->addOption('useHomepageImageAsHeader', 'FieldOptions', [
            'label' => __('plugins.themes.material.option.useHomepageImageAsHeader.label'),
            'description' => __('plugins.themes.material.option.useHomepageImageAsHeader.description'),
            'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.material.option.useHomepageImageAsHeader.option')
                ],
            ],
            'default' => false,
        ]);

        $this->addOption('baseColour', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.material.option.colour.label'),
            'options' => [
                [
                    'value' => 'sky',
                    'label' => 'Sky',
                ],
                [
                    'value' => 'blue',
                    'label' => 'Blue',
                ],
                [
                    'value' => 'indigo',
                    'label' => 'Indigo',
                ],
                [
                    'value' => 'purple',
                    'label' => 'Purple',
                ],
                [
                    'value' => 'violet',
                    'label' => 'Violet',
                ],
                [
                    'value' => 'teal',
                    'label' => 'Teal',
                ],
                [
                    'value' => 'emerald',
                    'label' => 'Emerald',
                ],
                [
                    'value' => 'green',
                    'label' => 'Green',
                ],
                [
                    'value' => 'orange',
                    'label' => 'Orange',
                ],
                [
                    'value' => 'amber',
                    'label' => 'Amber',
                ],
                [
                    'value' => 'rose',
                    'label' => 'Rose',
                ],
                [
                    'value' => 'slate',
                    'label' => 'Slate',
                ],
            ],
            'default' => 'sky',
        ]);

        $this->addOption('fontFamily', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.material.option.font.label'),
            'options' => [
                [
                    'value' => 'inter',
                    'label' => 'Inter (Modern Sans)',
                ],
                [
                    'value' => 'plus-jakarta-sans',
                    'label' => 'Plus Jakarta Sans',
                ],
                [
                    'value' => 'open-sans',
                    'label' => 'Open Sans',
                ],
                [
                    'value' => 'merriweather',
                    'label' => 'Merriweather (Academic Serif)',
                ],
                [
                    'value' => 'lora',
                    'label' => 'Lora (Editorial Serif)',
                ],
                [
                    'value' => 'roboto-serif',
                    'label' => 'Roboto Serif',
                ],
                [
                    'value' => 'cardo',
                    'label' => 'Cardo',
                ],
                [
                    'value' => 'cormorant',
                    'label' => 'Cormorant',
                ],
                [
                    'value' => 'old-standard-tt',
                    'label' => 'Old Standard TT',
                ],
                [
                    'value' => 'comic-neue',
                    'label' => 'Comic Neue',
                ],
                [
                    'value' => 'comic-sans',
                    'label' => 'Comic Sans',
                ],
            ],
            'default' => 'inter',
        ]);

        $this->addOption('showSocialShare', 'FieldOptions', [
            'label' => __('plugins.themes.material.option.showSocialShare.label'),
            'description' => __('plugins.themes.material.option.showSocialShare.description'),
            'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.material.option.showSocialShare.option'),
                ],
            ],
            'default' => true,
        ]);

        $this->addOption('showReadingTime', 'FieldOptions', [
            'label' => __('plugins.themes.material.option.showReadingTime.label'),
            'description' => __('plugins.themes.material.option.showReadingTime.description'),
            'options' => [
                [
                    'value' => true,
                    'label' => __('plugins.themes.material.option.showReadingTime.option'),
                ],
            ],
            'default' => true,
        ]);

        $this->addOption('announcementText', 'FieldText', [
            'label' => __('plugins.themes.material.option.announcementText.label'),
            'description' => __('plugins.themes.material.option.announcementText.description'),
            'default' => '',
        ]);

        // Add usage stats display options
        $this->addOption('displayStats', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.material.option.displayStats.label'),
            'options' => [
                [
                    'value' => 'none',
                    'label' => __('plugins.themes.material.option.displayStats.none'),
                ],
                [
                    'value' => 'bar',
                    'label' => __('plugins.themes.material.option.displayStats.bar'),
                ],
                [
                    'value' => 'line',
                    'label' => __('plugins.themes.material.option.displayStats.line'),
                ],
            ],
            'default' => 'none',
        ]);

        $this->addOption('primaryMenu', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.material.option.primaryMenu.label'),
            'options' => [
                [
                    'value' => 'vertical',
                    'label' => __('plugins.themes.material.option.primaryMenu.vertical'),
                ],
                [
                    'value' => 'horizontal',
                    'label' => __('plugins.themes.material.option.primaryMenu.horizontal'),
                ],
            ],
            'default' => 'horizontal',
        ]);

        $request = Application::get()->getRequest();

        $templateManager = TemplateManager::getManager($request);
        $templateManager->assign('jquery', $this->getJqueryPath($request));
        $templateManager->assign('jqueryUI', $this->getJqueryUIPath($request));

        if (!class_exists('PKPApplication', false)) { @class_alias('\PKP\core\PKPApplication', 'PKPApplication'); }
        if (!class_exists('PKPSubmission', false)) { @class_alias('\PKP\submission\PKPSubmission', 'PKPSubmission'); }
        if (!class_exists('Submission', false)) { @class_alias('\APP\submission\Submission', 'Submission'); }
        if (!class_exists('Journal', false)) { @class_alias('\APP\journal\Journal', 'Journal'); }
        $plugins = [
            'material_button_primary' => ['block', 'smartyMaterialButtonPrimary'],
            'material_button_secondary' => ['block', 'smartyMaterialButtonSecondary'],
            'material_label' => ['block', 'smartyMaterialLabel'],
            'material_select' => ['block', 'smartyMaterialSelect'],
            'material_dropdown' => ['block', 'smartyMaterialDropdown'],
            'material_dropdown_trigger' => ['block', 'smartyMaterialDropdownTrigger'],
            'material_dropdown_body' => ['block', 'smartyMaterialDropdownBody'],
            'material_dropdown_item' => ['block', 'smartyMaterialDropdownItem'],
            'material_menu' => ['block', 'smartyMaterialMenu'],
            'material_menu_item' => ['block', 'smartyMaterialMenuItem'],
            'material_menu_link' => ['block', 'smartyMaterialMenuLink'],
            'material_submenu' => ['block', 'smartyMaterialSubmenu'],
            'material_submenu_item' => ['block', 'smartyMaterialSubmenuItem'],
            'material_submenu_link' => ['block', 'smartyMaterialSubmenuLink'],
            'material_sidestack' => ['block', 'smartyMaterialSidestack'],
            'material_input' => ['function', 'smartyMaterialInput'],
            'material_checkbox' => ['function', 'smartyMaterialCheckbox'],
            'material_select_date_a11y' => ['function', 'smartyMaterialSelectDateA11y'],
            'material_reading_time' => ['function', 'smartyMaterialReadingTime']
        ];

        $registerClasses = function($templateMgr) use ($plugins) {
            if (method_exists($templateMgr, 'registerClass')) {
                $templateMgr->registerClass('PKPApplication', '\PKP\core\PKPApplication');
                $templateMgr->registerClass('PKPSubmission', '\PKP\submission\PKPSubmission');
                $templateMgr->registerClass('Submission', '\APP\submission\Submission');
                $templateMgr->registerClass('Journal', '\APP\journal\Journal');
                $templateMgr->registerClass('Role', '\PKP\security\Role');
            }
            if (method_exists($templateMgr, 'registerPlugin')) {
                $templateMgr->unregisterPlugin('modifier', 'is_array');
                $templateMgr->unregisterPlugin('modifier', 'is_object');
                $templateMgr->registerPlugin('modifier', 'is_array', 'is_array');
                $templateMgr->registerPlugin('modifier', 'is_object', 'is_object');
            }

            foreach ($plugins as $key => $value) {
                $templateMgr->unregisterPlugin($value[0], $key);
                $templateMgr->registerPlugin($value[0], $key, [$this, $value[1]], false);
            }
        };

        $registerClasses($templateManager);

        \PKP\plugins\Hook::add('TemplateManager::display', function($hookName, $args) use ($registerClasses) {
            $templateMgr = $args[0];
            $registerClasses($templateMgr);
            return false;
        });

        // Get homepage image and use as header background if useAsHeader is true
        $context = Application::get()->getRequest()->getContext();
        if ($context) {
            if ($this->getOption('useHomepageImageAsHeader')) {
                if ($homepageImage = $context->getLocalizedData('homepageImage')) {
                    $publicFileManager = new PublicFileManager();
                    $publicFilesDir = $request->getBaseUrl() . '/' . $publicFileManager->getContextFilesPath($context->getId());
                    $homepageImageUrl = $publicFilesDir . '/' . $homepageImage['uploadName'];
                    $templateManager->assign('homepageImageUrl', $homepageImageUrl);
                }
            }   
        }

        $templateManager->assign('gradientImageUrl',
            $request->getBaseUrl() . '/plugins/themes/material/resources/gradient-noise-purple.png');

        // Load primary stylesheet
        $this->addStyle('stylesheet', 'styles/dist/output.css');

        // Load alpinejs for this theme
        $this->addScript('alpinejs', 'js/alpinejs@3.x.x/dist/cdn.min.js');
        $this->addScript('mainjs', 'js/main.js');

        // Add navigation menu areas for this theme
        $this->addMenuArea(['primary', 'user']);
    }

    /**
     * Get the name of the settings file to be installed on new journal
     * creation.
     *
     * @return string
     */
    public function getContextSpecificPluginSettingsFile() {
        return $this->getPluginPath() . '/settings.xml';
    }

    /**
     * Get the name of the settings file to be installed site-wide when
     * OJS is installed.
     *
     * @return string
     */
    public function getInstallSitePluginSettingsFile() {
        return $this->getPluginPath() . '/settings.xml';
    }

    /**
     *
     * Get the display name of this plugin
     *
     * @return string
     */
    public function getDisplayName() {
        return __('plugins.themes.material.name');
    }

    /**
     * Get the description of this plugin
     *
     * @return string
     */
    public function getDescription() {
        return __('plugins.themes.material.description');
    }

    /**
     * Get the base colour
     *
     * @return string
     */
    public function getBaseColour() {
        $baseColour = $this->getOption('baseColour');
        $validColors = [
            'sky' => 1, 'blue' => 1, 'indigo' => 1, 'purple' => 1,
            'violet' => 1, 'teal' => 1, 'emerald' => 1, 'green' => 1,
            'orange' => 1, 'amber' => 1, 'rose' => 1, 'slate' => 1
        ];
        if (isset($validColors[$baseColour])) {
            return $baseColour;
        }
        return 'sky';
    }

    /**
     * Get the jquery path
     *
     * @return string
     */
    public function getJqueryPath($request) {
        // Load jQuery from a CDN or, if CDNs are disabled, from a local copy.
        $min = Config::getVar('general', 'enable_minified') ? '.min' : '';
        return $request->getBaseUrl() . '/js/build/jquery/jquery' . $min . '.js';
    }

    /**
     * Get the jqueryUI path
     *
     * @return string
     */
    public function getJqueryUIPath($request) {
        $min = Config::getVar('general', 'enable_minified') ? '.min' : '';
        return $request->getBaseUrl() . '/js/build/jquery-ui/jquery-ui' . $min . '.js';
    }

    public function smartyMaterialButtonPrimary($params, $content, $smarty, &$repeat) {
        $default = "";
        $default .= " rounded-full";
        $default .= " bg-{$this->getBaseColour()}-300";
        $default .= " py-2";
        $default .= " px-4";
        $default .= " text-sm";
        $default .= " font-semibold";
        $default .= " text-slate-900";
        $default .= " hover:bg-{$this->getBaseColour()}-200";
        $default .= " focus:outline-none";
        $default .= " focus-visible:outline-2";
        $default .= " focus-visible:outline-offset-2";
        $default .= " focus-visible:outline-{$this->getBaseColour()}-300/50";
        $default .= " active:bg-{$this->getBaseColour()}-500";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'name');
        array_push($attributes, 'type');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</button>";
        } else {
            return "<button $sa>";
        }
    }

    public function smartyMaterialButtonSecondary($params, $content, $smarty, &$repeat) {
        $default = "flex h-8 items-center justify-center rounded-lg shadow-md shadow-black/5 ring-1
            ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm
            dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300";

        $attributes = ['id', 'name', 'type'];

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</button>";
        } else {
            return "<button $sa>";
        }
    }

    public function smartyMaterialLabel($params, $content, $smarty, &$repeat) {
        $default = "";
        $default .= " leading-none";
        $default .= " font-medium";
        $default .= " text-sm";
        $default .= " text-gray-700";
        $default .= " dark:text-gray-400";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'name');
        array_push($attributes, 'for');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</label>";
        } else {
            return "<label $sa>";
        }
    }

    public function smartyMaterialSelect($params, $content, $smarty, &$repeat) {
        $default = "";
        $default .= " border-gray-300";
        $default .= " focus:border-{$this->getBaseColour()}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getBaseColour()}-200/50";
        $default .= " rounded-md";
        $default .= " shadow-sm";
        $default .= " dark:bg-gray-800";
        $default .= " dark:border-gray-500";
        $default .= " dark:text-white";


        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'type');
        array_push($attributes, 'name');
        array_push($attributes, 'checked');
        array_push($attributes, 'required');
        array_push($attributes, 'maxlength');
        array_push($attributes, 'autocomplete');
        array_push($attributes, 'aria-required');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        if (!$repeat) {
            return "$content</select>";
        } else {
            return "<select $sa>";
        }
    }

    public function smartyMaterialDropdown($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</div>";
        } else {
            return "<div x-data=\"{ open: false }\" class=\"relative text-left\">";
        }
    }

    public function smartyMaterialDropdownTrigger($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            return <<<HTML
                <a @mouseover="open = true" @mouseleave="open = false" href="{$params['url']}"
                    class="flex h-8 items-center text-slate-500 justify-center rounded-xl shadow-md shadow-black/5 ring-1
                        ring-black/5 dark:bg-slate-700 dark:ring-inset dark:ring-white/5 px-3 text-sm
                        dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300">
            HTML;
        }
    }

    public function smartyMaterialDropdownBody($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul></div>";
        } else {
            return <<<HTML
                <div @mouseover="open = true" @mouseleave="open = false" x-show="open"
                    x-transition:enter="transition ease-out duration-300" 
                    x-transition:enter-start="opacity-0 transform -translate-y-2" 
                    x-transition:enter-end="opacity-100 transform translate-y-0" 
                    x-transition:leave="transition ease-in duration-200" 
                    x-transition:leave-start="opacity-100 transform translate-y-0" 
                    x-transition:leave-end="opacity-0 transform -translate-y-2"
                    class="absolute right-0 z-10 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg
                        ring-1 ring-black/5 focus:outline-none dark:bg-slate-800">

                    <ul class="py-1" role="list">
            HTML;
        }
    }

    public function smartyMaterialDropdownItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a></li>";
        } else {
            return <<<HTML
                <li class="{$params['class']}">
                    <a href="{$params['url']}" class="text-gray-700 dark:text-gray-400 block px-4 py-2 text-sm">
            HTML;
        }
    }

    public function smartyMaterialMenu($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul>";
        } else {
            return <<<HTML
                <ul id="{$params['id']}" role="list" class="{$params['class']} space-y-9">
            HTML;
        }
    }

    public function smartyMaterialMenuItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</li>";
        } else {
            return <<<HTML
                <li class="{$params['class']}">
            HTML;
        }
    }

    public function smartyMaterialMenuLink($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            return <<<HTML
                <a href="{$params['url']}" class="font-display font-medium text-slate-900 dark:text-white">
            HTML;
        }
    }

    public function smartyMaterialSubmenu($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul>";
        } else {
            return <<<HTML
                <ul role="list" class="mt-2 space-y-2 border-l-2 border-slate-100 lg:mt-4 lg:space-y-4 lg:border-slate-200 dark:border-slate-800">
            HTML;
        }
    }

    public function smartyMaterialSubmenuItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</li>";
        } else {
            return <<<HTML
                <li class="{$params['class']} relative">
            HTML;
        }
    }

    public function smartyMaterialSubmenuLink($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            return <<<HTML
                <a href="{$params['url']}" class="block w-full pl-3.5 before:pointer-events-none before:absolute before:-left-1 before:top-1/2 before:h-1.5 before:w-1.5 before:-translate-y-1/2 before:rounded-full text-slate-500 before:hidden before:bg-slate-300 hover:text-slate-600 hover:before:block dark:text-slate-400 dark:before:bg-slate-700 dark:hover:text-slate-300">
            HTML;
        }
    }

    public function smartyMaterialSidestack($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return <<<HTML
                                $content
                            </div>
                        </div>
                    </div>
                </div>
            HTML;
        } else {
            return <<<HTML
                <div class="mr-4 {$params['class']}" x-data="{ open: false }" x-effect="document.body.classList.toggle('overflow-hidden', open)">
                    <button type="button"
                        class="p-2 rounded-xl text-slate-600 hover:text-slate-900 hover:bg-slate-100 dark:text-slate-300 dark:hover:text-white dark:hover:bg-slate-800 transition-colors focus:outline-none focus:ring-2 focus:ring-slate-300 dark:focus:ring-slate-700"
                        aria-label="Open navigation"
                        @click="open = true">
                        <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke="currentColor" class="h-6 w-6">
                            <path d="M4 6h16M4 12h16M4 18h16"></path>
                        </svg>
                    </button>

                    <div class="fixed inset-0 z-50 flex xl:hidden"
                        role="dialog"
                        aria-modal="true"
                        x-show="open"
                        x-cloak
                        @keydown.window.escape="open = false"
                        style="display: none;">
                        
                        <!-- Backdrop -->
                        <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm transition-opacity"
                            x-show="open"
                            x-transition:enter="transition ease-out duration-300"
                            x-transition:enter-start="opacity-0"
                            x-transition:enter-end="opacity-100"
                            x-transition:leave="transition ease-in duration-200"
                            x-transition:leave-start="opacity-100"
                            x-transition:leave-end="opacity-0"
                            @click="open = false">
                        </div>

                        <!-- Drawer Panel -->
                        <div class="relative flex w-full max-w-xs flex-col bg-white dark:bg-slate-900 shadow-2xl border-r border-slate-200/50 dark:border-slate-800/50"
                            x-show="open"
                            x-transition:enter="transition ease-out duration-300 transform"
                            x-transition:enter-start="-translate-x-full"
                            x-transition:enter-end="translate-x-0"
                            x-transition:leave="transition ease-in duration-200 transform"
                            x-transition:leave-start="translate-x-0"
                            x-transition:leave-end="-translate-x-full">
                            
                            <!-- Drawer Header -->
                            <div class="flex items-center justify-between px-5 pt-5 pb-3 border-b border-slate-100 dark:border-slate-800">
                                <span class="text-xs font-semibold uppercase tracking-wider text-slate-400 dark:text-slate-500">Navigation</span>
                                <button type="button"
                                    class="p-2 rounded-xl text-slate-400 hover:text-slate-700 hover:bg-slate-100 dark:hover:bg-slate-800 dark:hover:text-slate-200 transition-colors focus:outline-none"
                                    aria-label="Close navigation"
                                    @click="open = false">
                                    <svg class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2" stroke-linecap="round">
                                        <path d="M6 18L18 6M6 6l12 12"></path>
                                    </svg>
                                </button>
                            </div>

                            <!-- Drawer Body -->
                            <div class="flex-1 overflow-y-auto px-5 py-6 space-y-6 scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-700">
            HTML;
        }
    }


    public function smartyMaterialInput($params, $smarty) {
        $default = "";
        $default .= " border-gray-300";
        $default .= " focus:border-{$this->getBaseColour()}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getBaseColour()}-200/50";
        $default .= " rounded-md";
        $default .= " shadow-sm";
        $default .= " dark:bg-gray-800";
        $default .= " dark:border-gray-500";
        $default .= " dark:text-white";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'type');
        array_push($attributes, 'name');
        array_push($attributes, 'checked');
        array_push($attributes, 'required');
        array_push($attributes, 'maxlength');
        array_push($attributes, 'autocomplete');
        array_push($attributes, 'aria-required');
        array_push($attributes, 'placeholder');

        $sa = '';
        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        return "<input $sa>";
    }

    public function smartyMaterialCheckbox($params, $smarty) {
        $default = "";
        $default .= " rounded-md";
        $default .= " border-gray-300";
        $default .= " text-{$this->getBaseColour()}-600";
        $default .= " shadow-sm";
        $default .= " focus:border-{$this->getBaseColour()}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getBaseColour()}-200/50";
        $default .= " dark:bg-gray-800";

        $attributes = array();
        array_push($attributes, 'id');
        array_push($attributes, 'name');
        array_push($attributes, 'value');
        array_push($attributes, 'checked');
        array_push($attributes, 'required');

        $sa = '';

        foreach ($attributes as $attribute) {
            if (isset($params[$attribute])) {
                $sa .= ' ';
                $sa .= "$attribute=\"{$params[$attribute]}\"";
            }
        }

        $sa .= isset($params['class'])
            ? " class=\"$default {$params['class']}\""
            : " class=\"$default\"";

        return "<input type=\"checkbox\" $sa>";
    }

    public function smartyMaterialSelectDateA11y($params, $smarty)
    {
        $default = "";
        $default .= " border-gray-300";
        $default .= " focus:border-{$this->getBaseColour()}-300";
        $default .= " focus:ring";
        $default .= " focus:ring-{$this->getBaseColour()}-200/50";
        $default .= " rounded-md";
        $default .= " shadow-sm";
        $default .= " dark:bg-gray-800";
        $default .= " dark:border-gray-500";
        $default .= " dark:text-white";


        if (!isset($params['prefix'], $params['legend'], $params['start_year'], $params['end_year'])) {
            throw new Exception('You must provide a prefix, legend, start_year and end_year when using html_select_date_a11y.');
        }
        $prefix = $params['prefix'];
        $legend = $params['legend'];
        $time = $params['time'] ?? '';
        $startYear = $params['start_year'];
        $endYear = $params['end_year'];
        $yearEmpty = $params['year_empty'] ?? '';
        $monthEmpty = $params['month_empty'] ?? '';
        $dayEmpty = $params['day_empty'] ?? '';
        $yearLabel = $params['year_label'] ?? __('common.year');
        $monthLabel = $params['month_label'] ?? __('common.month');
        $dayLabel = $params['day_label'] ?? __('common.day');

        $years = [];
        $i = $startYear;
        while ($i <= $endYear) {
            $years[$i] = $i;
            $i++;
        }

        $months = [];
        for ($i = 1; $i <= 12; $i++) {
            $months[$i] = date('M', strtotime('2020-' . $i . '-01'));
        }

        $days = [];
        for ($i = 1; $i <= 31; $i++) {
            $days[$i] = $i;
        }

        $currentYear = $currentMonth = $currentDay = '';
        if ($time) {
            $currentYear = (int) substr($time, 0, 4);
            $currentMonth = (int) substr($time, 5, 2);
            $currentDay = (int) substr($time, 8, 2);
        }

        $output = '<fieldset><legend>' . $legend . '</legend>';
        $output .= '<div class="space-x-2">';
        //$output .= '<label for="' . $prefix . 'Year">' . $yearLabel . '</label>';
        $output .= '<select id="' . $prefix . 'Year" name="' . $prefix . 'Year" class="' . $default . '">';
        $output .= '<option>' . $yearEmpty . '</option>';
        foreach ($years as $value => $label) {
            $selected = $currentYear === $value ? ' selected' : '';
            $output .= '<option value="' . $value . '"' . $selected . '>' . $label . '</option>';
        }
        $output .= '</select>';
        //$output .= '<label for="' . $prefix . 'Month">' . $monthLabel . '</label>';
        $output .= '<select id="' . $prefix . 'Month" name="' . $prefix . 'Month" class="' . $default . '">';
        $output .= '<option>' . $monthEmpty . '</option>';
        foreach ($months as $value => $label) {
            $selected = $currentMonth === $value ? ' selected' : '';
            $output .= '<option value="' . $value . '"' . $selected . '>' . $label . '</option>';
        }
        $output .= '</select>';
        //$output .= '<label for="' . $prefix . 'Day">' . $dayLabel . '</label>';
        $output .= '<select id="' . $prefix . 'Day" name="' . $prefix . 'Day" class="' . $default . '">';
        $output .= '<option>' . $dayEmpty . '</option>';
        foreach ($days as $value => $label) {
            $selected = $currentDay === $value ? ' selected' : '';
            $output .= '<option value="' . $value . '"' . $selected . '>' . $label . '</option>';
        }
        $output .= '</select>';
        $output .= '</div>';
        $output .= '</fieldset>';

        return $output;
    }

    /**
     * Smarty plugin helper for calculating estimated reading time
     */
    public function smartyMaterialReadingTime($params, $smarty) {
        $text = $params['text'] ?? '';
        $cleanText = strip_tags($text);
        $wordCount = str_word_count($cleanText);
        $minutes = max(1, (int) ceil($wordCount / 200));
        return $minutes . ' ' . __('plugins.themes.material.readingTime.minutes');
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\material\MaterialThemePlugin', '\MaterialThemePlugin');
}

