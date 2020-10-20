<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class CurriculumVitaeController extends AbstractController
{
    /**
     * @Route("/cv", name="curriculum_vitae")
     */
    public function index()
    {
        return $this->render('curriculum_vitae/index.html.twig', [
            'controller_name' => 'CurriculumVitaeController',
        ]);
    }
}
