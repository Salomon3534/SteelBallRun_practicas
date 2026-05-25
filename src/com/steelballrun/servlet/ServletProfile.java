package com.steelballrun.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.steelballrun.dao.MedicalCheckDAO;
import com.steelballrun.dao.MountDAO;
import com.steelballrun.dao.PersonDAO;
import com.steelballrun.dao.RunnerDAO;
import com.steelballrun.dao.StageDAO;
import com.steelballrun.model.Mount;
import com.steelballrun.model.Person;
import com.steelballrun.model.Runner;
import com.steelballrun.model.Stage;
import com.steelballrun.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@SuppressWarnings("serial")
@WebServlet("/profile")
public class ServletProfile extends HttpServlet {

	private RunnerDAO runnerDAO;
	private PersonDAO personDAO;
	private MountDAO mountDAO;
	private StageDAO stageDAO;
	private MedicalCheckDAO medicalCheckDAO;

	@Override
	public void init() {
		runnerDAO = new RunnerDAO();
		personDAO = new PersonDAO();
		mountDAO = new MountDAO();
		stageDAO = new StageDAO();
		medicalCheckDAO = new MedicalCheckDAO();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		HttpSession session = req.getSession(false);
		if (session == null || session.getAttribute("loggedUser") == null) {
			res.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		User user = (User) session.getAttribute("loggedUser");
		req.setAttribute("loggedUser", user);

		// obtener el nombre del usuario para el PDF
		req.setAttribute("profileUsername", user.getUsername());

		if ("user".equals(user.getRole()) && user.getRunnerId() != null) {

			Runner runner = runnerDAO.getRunnerByBib(user.getRunnerId());
			if (runner != null) {
				req.setAttribute("runner", runner);

				// mostrar passkey
				req.setAttribute("profilePasskey", runner.getPasskey());

				// persona y montura
				Person person = personDAO.getPersonByID(runner.getIdPerson());
				req.setAttribute("person", person);

				Mount mount = mountDAO.getMountByID(runner.getIdMount());
				req.setAttribute("mount", mount);

				// ranking
				java.util.List<Runner> all = runnerDAO.listRunnersTop(25);
				int rank = 1;
				for (Runner r : all) {
					if (r.getBib() == runner.getBib())
						break;
					rank++;
				}
				req.setAttribute("rank", rank);
				req.setAttribute("totalRunners", all.size());

				// etapa actual
				if (runner.getIdStage() != null) {
					Stage stage = stageDAO.getStageByID(runner.getIdStage());
					req.setAttribute("currentStage", stage);
				}

				// chequeos médicos
				List<Map<String, Object>> checks = medicalCheckDAO.listByRunner(runner.getBib());
				req.setAttribute("medicalChecks", checks);
			}
		}

		req.getRequestDispatcher("/profile.jsp").forward(req, res);
	}
}
