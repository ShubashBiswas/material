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

        /**
         * Tailwind CSS Safelist for dynamic theme colors
         * bg-sky-50 bg-sky-100 bg-sky-200 bg-sky-300 bg-sky-400 bg-sky-500 bg-sky-600 bg-sky-700 bg-sky-800 text-sky-300 text-sky-400 text-sky-500 text-sky-600 text-sky-700 text-sky-800 border-sky-200 border-sky-500 border-sky-800 hover:bg-sky-200 hover:bg-sky-700 active:bg-sky-500 ring-sky-500 focus:ring-sky-500 focus-visible:outline-sky-300 group-hover:text-sky-600 dark:group-hover:text-sky-400
         * bg-blue-50 bg-blue-100 bg-blue-200 bg-blue-300 bg-blue-400 bg-blue-500 bg-blue-600 bg-blue-700 bg-blue-800 text-blue-300 text-blue-400 text-blue-500 text-blue-600 text-blue-700 text-blue-800 border-blue-200 border-blue-500 border-blue-800 hover:bg-blue-200 hover:bg-blue-700 active:bg-blue-500 ring-blue-500 focus:ring-blue-500 focus-visible:outline-blue-300 group-hover:text-blue-600 dark:group-hover:text-blue-400
         * bg-indigo-50 bg-indigo-100 bg-indigo-200 bg-indigo-300 bg-indigo-400 bg-indigo-500 bg-indigo-600 bg-indigo-700 bg-indigo-800 text-indigo-300 text-indigo-400 text-indigo-500 text-indigo-600 text-indigo-700 text-indigo-800 border-indigo-200 border-indigo-500 border-indigo-800 hover:bg-indigo-200 hover:bg-indigo-700 active:bg-indigo-500 ring-indigo-500 focus:ring-indigo-500 focus-visible:outline-indigo-300 group-hover:text-indigo-600 dark:group-hover:text-indigo-400
         * bg-purple-50 bg-purple-100 bg-purple-200 bg-purple-300 bg-purple-400 bg-purple-500 bg-purple-600 bg-purple-700 bg-purple-800 text-purple-300 text-purple-400 text-purple-500 text-purple-600 text-purple-700 text-purple-800 border-purple-200 border-purple-500 border-purple-800 hover:bg-purple-200 hover:bg-purple-700 active:bg-purple-500 ring-purple-500 focus:ring-purple-500 focus-visible:outline-purple-300 group-hover:text-purple-600 dark:group-hover:text-purple-400
         * bg-violet-50 bg-violet-100 bg-violet-200 bg-violet-300 bg-violet-400 bg-violet-500 bg-violet-600 bg-violet-700 bg-violet-800 text-violet-300 text-violet-400 text-violet-500 text-violet-600 text-violet-700 text-violet-800 border-violet-200 border-violet-500 border-violet-800 hover:bg-violet-200 hover:bg-violet-700 active:bg-violet-500 ring-violet-500 focus:ring-violet-500 focus-visible:outline-violet-300 group-hover:text-violet-600 dark:group-hover:text-violet-400
         * bg-teal-50 bg-teal-100 bg-teal-200 bg-teal-300 bg-teal-400 bg-teal-500 bg-teal-600 bg-teal-700 bg-teal-800 text-teal-300 text-teal-400 text-teal-500 text-teal-600 text-teal-700 text-teal-800 border-teal-200 border-teal-500 border-teal-800 hover:bg-teal-200 hover:bg-teal-700 active:bg-teal-500 ring-teal-500 focus:ring-teal-500 focus-visible:outline-teal-300 group-hover:text-teal-600 dark:group-hover:text-teal-400
         * bg-emerald-50 bg-emerald-100 bg-emerald-200 bg-emerald-300 bg-emerald-400 bg-emerald-500 bg-emerald-600 bg-emerald-700 bg-emerald-800 text-emerald-300 text-emerald-400 text-emerald-500 text-emerald-600 text-emerald-700 text-emerald-800 border-emerald-200 border-emerald-500 border-emerald-800 hover:bg-emerald-200 hover:bg-emerald-700 active:bg-emerald-500 ring-emerald-500 focus:ring-emerald-500 focus-visible:outline-emerald-300 group-hover:text-emerald-600 dark:group-hover:text-emerald-400
         * bg-green-50 bg-green-100 bg-green-200 bg-green-300 bg-green-400 bg-green-500 bg-green-600 bg-green-700 bg-green-800 text-green-300 text-green-400 text-green-500 text-green-600 text-green-700 text-green-800 border-green-200 border-green-500 border-green-800 hover:bg-green-200 hover:bg-green-700 active:bg-green-500 ring-green-500 focus:ring-green-500 focus-visible:outline-green-300 group-hover:text-green-600 dark:group-hover:text-green-400
         * bg-orange-50 bg-orange-100 bg-orange-200 bg-orange-300 bg-orange-400 bg-orange-500 bg-orange-600 bg-orange-700 bg-orange-800 text-orange-300 text-orange-400 text-orange-500 text-orange-600 text-orange-700 text-orange-800 border-orange-200 border-orange-500 border-orange-800 hover:bg-orange-200 hover:bg-orange-700 active:bg-orange-500 ring-orange-500 focus:ring-orange-500 focus-visible:outline-orange-300 group-hover:text-orange-600 dark:group-hover:text-orange-400
         * bg-amber-50 bg-amber-100 bg-amber-200 bg-amber-300 bg-amber-400 bg-amber-500 bg-amber-600 bg-amber-700 bg-amber-800 text-amber-300 text-amber-400 text-amber-500 text-amber-600 text-amber-700 text-amber-800 border-amber-200 border-amber-500 border-amber-800 hover:bg-amber-200 hover:bg-amber-700 active:bg-amber-500 ring-amber-500 focus:ring-amber-500 focus-visible:outline-amber-300 group-hover:text-amber-600 dark:group-hover:text-amber-400
         * bg-rose-50 bg-rose-100 bg-rose-200 bg-rose-300 bg-rose-400 bg-rose-500 bg-rose-600 bg-rose-700 bg-rose-800 text-rose-300 text-rose-400 text-rose-500 text-rose-600 text-rose-700 text-rose-800 border-rose-200 border-rose-500 border-rose-800 hover:bg-rose-200 hover:bg-rose-700 active:bg-rose-500 ring-rose-500 focus:ring-rose-500 focus-visible:outline-rose-300 group-hover:text-rose-600 dark:group-hover:text-rose-400
         * bg-slate-50 bg-slate-100 bg-slate-200 bg-slate-300 bg-slate-400 bg-slate-500 bg-slate-600 bg-slate-700 bg-slate-800 text-slate-300 text-slate-400 text-slate-500 text-slate-600 text-slate-700 text-slate-800 border-slate-200 border-slate-500 border-slate-800 hover:bg-slate-200 hover:bg-slate-700 active:bg-slate-500 ring-slate-500 focus:ring-slate-500 focus-visible:outline-slate-300 group-hover:text-slate-600 dark:group-hover:text-slate-400
         */

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
                $templateMgr->unregisterPlugin('modifier', 'method_exists');
                $templateMgr->unregisterPlugin('modifier', 'is_string');
                $templateMgr->registerPlugin('modifier', 'is_array', 'is_array');
                $templateMgr->registerPlugin('modifier', 'is_object', 'is_object');
                $templateMgr->registerPlugin('modifier', 'method_exists', 'method_exists');
                $templateMgr->registerPlugin('modifier', 'is_string', 'is_string');
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

        // Get homepage image or journal thumbnail/cover and assign to template
        $context = Application::get()->getRequest()->getContext();
        if ($context) {
            $publicFileManager = new PublicFileManager();
            $publicFilesDir = $request->getBaseUrl() . '/' . $publicFileManager->getContextFilesPath($context->getId());
            $headerThumbnailUrl = null;

            if ($homepageImage = $context->getLocalizedData('homepageImage')) {
                $headerThumbnailUrl = $publicFilesDir . '/' . $homepageImage['uploadName'];
            } elseif ($thumbnailImage = $context->getLocalizedData('journalThumbnail')) {
                $headerThumbnailUrl = $publicFilesDir . '/' . $thumbnailImage['uploadName'];
            } elseif ($logoImage = $context->getLocalizedData('pageHeaderLogoImage')) {
                $headerThumbnailUrl = $publicFilesDir . '/' . $logoImage['uploadName'];
            } else {
                $currentIssue = \APP\facades\Repo::issue()->getCurrent($context->getId());
                if ($currentIssue && $currentIssue->getLocalizedCoverImageUrl()) {
                    $headerThumbnailUrl = $currentIssue->getLocalizedCoverImageUrl();
                }
            }

            if ($headerThumbnailUrl) {
                $templateManager->assign('headerThumbnailUrl', $headerThumbnailUrl);
                $templateManager->assign('homepageImageUrl', $headerThumbnailUrl);
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
            return "<div x-data=\"{ open: false }\" @mouseenter=\"open = true\" @mouseleave=\"open = false\" class=\"relative text-left\">";
        }
    }

    public function smartyMaterialDropdownTrigger($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            $url = isset($params['url']) ? $params['url'] : '#';
            $baseColour = $this->getBaseColour();
            return <<<HTML
                <a href="{$url}"
                    class="inline-flex items-center space-x-1.5 px-4 py-2 rounded-xl text-xs sm:text-sm font-semibold text-slate-700 dark:text-slate-200 hover:text-{$baseColour}-600 dark:hover:text-{$baseColour}-400 hover:bg-white dark:hover:bg-slate-800 transition-all">
            HTML;
        }
    }

    public function smartyMaterialDropdownBody($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul></div>";
        } else {
            return <<<HTML
                <div x-show="open"
                    x-transition:enter="transition ease-out duration-150" 
                    x-transition:enter-start="opacity-0 scale-95 -translate-y-1" 
                    x-transition:enter-end="opacity-100 scale-100 translate-y-0" 
                    x-transition:leave="transition ease-in duration-100" 
                    x-transition:leave-start="opacity-100 scale-100 translate-y-0" 
                    x-transition:leave-end="opacity-0 scale-95 -translate-y-1"
                    class="absolute left-0 z-50 mt-2 w-56 origin-top-left rounded-2xl bg-white dark:bg-slate-800 shadow-2xl border border-slate-200/80 dark:border-slate-700/80 p-2 text-slate-900 dark:text-white"
                    style="display: none;">

                    <ul class="space-y-1" role="list">
            HTML;
        }
    }

    public function smartyMaterialDropdownItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a></li>";
        } else {
            $url = isset($params['url']) ? $params['url'] : '#';
            $class = isset($params['class']) ? $params['class'] : '';
            $baseColour = $this->getBaseColour();
            return <<<HTML
                <li class="{$class}">
                    <a href="{$url}" class="flex items-center space-x-2 px-3.5 py-2 rounded-xl text-xs sm:text-sm font-medium text-slate-700 dark:text-slate-100 hover:text-{$baseColour}-600 dark:hover:text-{$baseColour}-400 hover:bg-slate-100 dark:hover:bg-slate-700/80 transition-colors">
            HTML;
        }
    }



    public function smartyMaterialMenu($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul>";
        } else {
            $class = isset($params['class']) ? $params['class'] : '';
            $id = isset($params['id']) ? "id=\"{$params['id']}\"" : '';
            return <<<HTML
                <ul {$id} role="list" class="{$class} space-y-6">
            HTML;
        }
    }

    public function smartyMaterialMenuItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</li>";
        } else {
            $class = isset($params['class']) ? $params['class'] : '';
            $id = isset($params['id']) ? "id=\"{$params['id']}\"" : '';
            return <<<HTML
                <li {$id} class="{$class} group rounded-2xl bg-white dark:bg-slate-900/60 border border-slate-200/70 dark:border-slate-800/80 p-5 shadow-sm hover:shadow-md transition-all duration-200">
            HTML;
        }
    }

    public function smartyMaterialMenuLink($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</h2>";
        } else {
            $url = isset($params['url']) ? $params['url'] : '#';
            $class = isset($params['class']) ? $params['class'] : '';
            return <<<HTML
                <h2 class="{$class} text-xs font-bold uppercase tracking-wider text-slate-900 dark:text-white pb-2.5 mb-3 border-b border-slate-100 dark:border-slate-800/80 flex items-center space-x-2">
            HTML;
        }
    }

    public function smartyMaterialSubmenu($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</ul>";
        } else {
            $class = isset($params['class']) ? $params['class'] : '';
            return <<<HTML
                <ul role="list" class="{$class} space-y-1.5 text-sm">
            HTML;
        }
    }

    public function smartyMaterialSubmenuItem($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</li>";
        } else {
            $class = isset($params['class']) ? $params['class'] : '';
            return <<<HTML
                <li class="{$class} relative">
            HTML;
        }
    }

    public function smartyMaterialSubmenuLink($params, $content, $smarty, &$repeat) {
        if (!$repeat) {
            return "$content</a>";
        } else {
            $url = isset($params['url']) ? $params['url'] : '#';
            $class = isset($params['class']) ? $params['class'] : '';
            $baseColour = $this->getBaseColour();
            return <<<HTML
                <a href="{$url}" class="{$class} block py-1.5 px-2.5 rounded-xl text-slate-600 dark:text-slate-300 hover:text-{$baseColour}-600 dark:hover:text-{$baseColour}-400 hover:bg-slate-50 dark:hover:bg-slate-800/60 transition-colors font-medium text-xs sm:text-sm">
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
            $baseColour = $this->getBaseColour();
            return <<<HTML
                <div class="mr-3 {$params['class']}" x-data="{ open: false }" x-effect="document.body.classList.toggle('overflow-hidden', open)">
                    <button type="button"
                        class="flex h-9 w-9 items-center justify-center rounded-xl bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 text-slate-800 dark:text-white ring-1 ring-slate-900/5 dark:ring-white/10 shadow-sm transition-all focus:outline-none focus:ring-2 focus:ring-{$baseColour}-500"
                        aria-label="Open main navigation menu"
                        :aria-expanded="open.toString()"
                        aria-controls="mobile-navigation-drawer"
                        @click="open = true">
                        <svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke-width="2.5" stroke-linecap="round" stroke="currentColor" class="h-5 w-5 text-slate-800 dark:text-white">
                            <path d="M4 6h16M4 12h16M4 18h16"></path>
                        </svg>
                    </button>

                    <div id="mobile-navigation-drawer"
                        class="fixed inset-0 z-[9999] flex lg:hidden"
                        role="dialog"
                        aria-modal="true"
                        aria-label="Mobile Navigation"
                        x-show="open"
                        x-cloak
                        @keydown.window.escape="open = false"
                        style="display: none;">
                        
                        <!-- Backdrop -->
                        <div class="fixed inset-0 bg-slate-950/70 backdrop-blur-sm z-[9998] transition-opacity"
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
                        <div class="relative flex w-80 sm:w-96 max-w-[85vw] flex-col bg-white dark:bg-slate-900 shadow-2xl border-r border-slate-200/80 dark:border-slate-800 text-slate-900 dark:text-white h-full z-[9999]"
                            x-show="open"
                            x-transition:enter="transition ease-out duration-300 transform"
                            x-transition:enter-start="-translate-x-full"
                            x-transition:enter-end="translate-x-0"
                            x-transition:leave="transition ease-in duration-200 transform"
                            x-transition:leave-start="translate-x-0"
                            x-transition:leave-end="-translate-x-full">

                            
                            <!-- Drawer Header -->
                            <div class="flex items-center justify-between px-5 py-4 border-b border-slate-100 dark:border-slate-800">
                                <div class="flex items-center space-x-2.5">
                                    <div class="h-6 w-1 rounded-full bg-{$baseColour}-500"></div>
                                    <span class="text-sm font-extrabold text-slate-900 dark:text-white tracking-tight">Navigation</span>
                                </div>
                                <button type="button"
                                    class="flex h-8 w-8 items-center justify-center rounded-xl text-slate-500 hover:text-slate-900 dark:text-slate-400 dark:hover:text-white bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 transition-colors focus:outline-none focus:ring-2 focus:ring-{$baseColour}-500"
                                    aria-label="Close navigation menu"
                                    @click="open = false">
                                    <svg class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2.5" stroke-linecap="round">
                                        <path d="M6 18L18 6M6 6l12 12"></path>
                                    </svg>
                                </button>
                            </div>

                            <!-- Drawer Body -->
                            <div class="flex-1 overflow-y-auto p-4 space-y-4 text-slate-900 dark:text-white scrollbar-thin scrollbar-thumb-slate-300 dark:scrollbar-thumb-slate-700">
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

