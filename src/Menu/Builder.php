<?php

namespace App\Menu;

use Knp\Menu\FactoryInterface;
use Knp\Menu\ItemInterface;

/**
 * Class Builder
 * @package App\Menu
 */
class Builder
{
    /**
     * @var FactoryInterface
     */
    private $factory;

    /**
     * Builder constructor.
     * @param FactoryInterface $factory
     */
    public function __construct(FactoryInterface $factory)
    {
        $this->factory = $factory;
    }

    /**
     * @param array $options
     * @return ItemInterface
     */
    public function createMainMenu(array $options): ItemInterface
    {
        $menu = $this->factory->createItem('root');
        $menu->setChildrenAttribute('class', 'navbar-nav text-uppercase ml-auto');

        $menu->addChild('Blog', ['route' => 'blog'])
            ->setLinkAttribute('class', 'nav-link')
            ->setAttribute('class', 'nav-item');

        $menu->addChild('Cheat sheet', ['route' => 'cheat_sheet'])
            ->setLinkAttribute('class', 'nav-link')
            ->setAttribute('class', 'nav-item');

        $menu->addChild('CV', ['route' => 'curriculum_vitae'])
            ->setLinkAttribute('class', 'nav-link')
            ->setAttribute('class', 'nav-item');

        $menu->addChild('Contact', ['uri' => '#contact'])
            ->setLinkAttribute('class', 'nav-link')
            ->setAttribute('class', 'nav-item');

        return $menu;
    }
}