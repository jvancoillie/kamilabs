<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class CheatSheetController extends AbstractController
{
    /**
     * @Route("/cheat-sheet", name="cheat_sheet")
     */
    public function index()
    {
        return $this->render('cheat_sheet/index.html.twig');
    }
}
